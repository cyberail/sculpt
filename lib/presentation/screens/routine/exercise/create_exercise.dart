import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/create_exercise/exercise_cubit.dart';
import 'package:sculpt/bloc/routine/routine_cubit.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/large_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/fields/default_text_field.dart';
import 'package:sculpt/presentation/ui_kit/snackbar/error_snackbar.dart';
import 'package:sculpt/utils/validators.dart';

class CreateExercise extends StatefulWidget {
  final Routine routine;
  final Exercise? exercise;
  const CreateExercise({super.key, required this.routine, this.exercise});

  @override
  State<CreateExercise> createState() => _CreateExerciseState();
}

class _CreateExerciseState extends State<CreateExercise> {
  final _fromKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final timeController = TextEditingController();
  final setsController = TextEditingController();
  final repsController = TextEditingController();
  final restAfterController = TextEditingController();
  final restBetweenController = TextEditingController();

  final focusNode = FocusNode();

  WorkoutType? selectedWorkoutType;
  Exercise? exercise;
  late Routine routine;

  @override
  void initState() {
    exercise = widget.exercise;
    routine = widget.routine;
    selectedWorkoutType = exercise?.type;
    setsController.addListener(() => setState(() {}));
    super.initState();
  }

  String get title => exercise == null ? "Create Exercise" : "Exercise: ${exercise?.name ?? ''}";

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExerciseCubit, ExerciseState>(
      listener: (context, state) {
        if (state.event == ExerciseEvent.createFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiKitSnackBars.error(context, label: "Failed to create the exercise"),
          );
        }
        if (state.event == ExerciseEvent.createSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiKitSnackBars.success(context, label: "Exercise successfully created"),
          );
          context.read<RoutineCubit>().getById(routine);
          setState(() {
            selectedWorkoutType = null;
            nameController.clear();
            timeController.clear();
            setsController.clear();
            repsController.clear();
            restAfterController.clear();
            restBetweenController.clear();
          });
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Scaffold(
          appBar: defaultAppBar(
            context,
            title,
          ),
          backgroundColor: UIKitColors.primaryColor,
          body: SingleChildScrollView(
            child: Form(
                key: _fromKey,
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextField(
                        controller: nameController,
                        label: "Exercise name",
                        hintText: "Dead-lift etc.",
                        validator: (value) => Validators.emptyTextValidation(context, value),
                      ),
                      const SizedBox(height: 20),
                      DropdownButton(
                        itemHeight: 50,
                        value: selectedWorkoutType,
                        hint: const Text(
                          "Type: timed or sets",
                          style: TextStyle(color: UIKitColors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        style: const TextStyle(color: UIKitColors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        dropdownColor: UIKitColors.black,
                        isExpanded: true,
                        items: WorkoutType.validValues
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  enabled: true,
                                  child: Text(
                                    e.val,
                                    style: const TextStyle(
                                      color: UIKitColors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedWorkoutType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      ...loadRepetitionField(context),
                      getRestBetween(context),
                      getRestAfter(context),
                      const SizedBox(height: 40),
                      LargeBtn(
                        label: "Create",
                        icon: Icons.add,
                        onTap: () => _validateAndUpdate(context),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget getRestBetween(BuildContext context) {
    final sets = int.tryParse(setsController.text);
    if (sets == null || sets <= 1) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: DefaultTextField(
        controller: restBetweenController,
        inputType: TextInputType.number,
        label: "Resting minutes between reps",
        hintText: "e.g. 1",
        validator: (value) => Validators.emptyTextValidation(context, value),
      ),
    );
  }

  Widget getRestAfter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: DefaultTextField(
        controller: restAfterController,
        inputType: TextInputType.number,
        label: "Duration in minutes after exercise",
        hintText: "e.g. 2",
        validator: (value) => Validators.emptyTextValidation(context, value),
      ),
    );
  }

  List<Widget> loadRepetitionField(BuildContext context) {
    if (selectedWorkoutType == WorkoutType.reps) {
      return [
        DefaultTextField(
          controller: setsController,
          inputType: TextInputType.number,
          label: "Number of sets",
          hintText: "e.g. 3",
          validator: (value) => Validators.emptyTextValidation(context, value),
        ),
        const SizedBox(height: 20),
        DefaultTextField(
          controller: repsController,
          inputType: TextInputType.number,
          label: "Number of reps",
          hintText: "e.g. 12",
          validator: (value) => Validators.emptyTextValidation(context, value),
        )
      ];
    } else if (selectedWorkoutType == WorkoutType.timeReps) {
      return [
        DefaultTextField(
          controller: setsController,
          inputType: TextInputType.number,
          label: "Number of sets",
          hintText: "e.g. 3",
          validator: (value) => Validators.emptyTextValidation(context, value),
        ),
        const SizedBox(height: 20),
        DefaultTextField(
          controller: timeController,
          inputType: TextInputType.number,
          label: "Duration in minutes",
          hintText: "e.g. 2",
          validator: (value) => Validators.emptyTextValidation(context, value),
        )
      ];
    } else {
      return [const SizedBox.shrink()];
    }
  }

  _validateAndUpdate(BuildContext context) {
    if (_fromKey.currentState?.validate() == false || selectedWorkoutType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        UiKitSnackBars.error(context, label: "Fill all the fields"),
      );
      return;
    }

    if (exercise != null) {
      context.read<ExerciseCubit>().update(
            routine,
            exercise!,
            name: nameController.text,
            type: selectedWorkoutType ?? WorkoutType.timeReps,
            time: double.tryParse(timeController.text),
            sets: int.tryParse(setsController.text),
            reps: int.tryParse(repsController.text),
          );
    } else {
      context.read<ExerciseCubit>().create(
            routine,
            name: nameController.text,
            type: selectedWorkoutType ?? WorkoutType.timeReps,
            time: double.tryParse(timeController.text),
            sets: int.tryParse(setsController.text),
            reps: int.tryParse(repsController.text),
            restBetween: double.tryParse(restBetweenController.text),
            restAfter: double.tryParse(restAfterController.text),
          );
    }
  }
}
