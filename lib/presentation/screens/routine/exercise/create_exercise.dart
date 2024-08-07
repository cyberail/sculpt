import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  final focusNode = FocusNode();

  WorkoutType? selectedWorkoutType;
  Exercise? exercise;
  late Routine routine;

  @override
  void initState() {
    exercise = widget.exercise;
    routine = widget.routine;
    selectedWorkoutType = exercise?.type;
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
          body: Form(
              key: _fromKey,
              child: Container(
                margin: EdgeInsets.only(top: 30),
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
                      style: TextStyle(color: UIKitColors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      dropdownColor: UIKitColors.black,
                      isExpanded: true,
                      items: WorkoutType.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.val,
                                  style: TextStyle(
                                    color: UIKitColors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                enabled: true,
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
    } else if (selectedWorkoutType == WorkoutType.time) {
      return [
        DefaultTextField(
          controller: timeController,
          inputType: TextInputType.number,
          label: "Duration in minutes",
          hintText: "Dead-lift etc.",
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
            type: selectedWorkoutType ?? WorkoutType.time,
            time: double.tryParse(timeController.text),
            sets: int.tryParse(setsController.text),
            reps: int.tryParse(repsController.text),
          );
    } else {
      context.read<ExerciseCubit>().create(
            routine,
            name: nameController.text,
            type: selectedWorkoutType ?? WorkoutType.time,
            time: double.tryParse(timeController.text),
            sets: int.tryParse(setsController.text),
            reps: int.tryParse(repsController.text),
          );
    }
  }
}
