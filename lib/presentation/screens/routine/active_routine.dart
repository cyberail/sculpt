import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/routine_control/routine_control_cubit.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/screens/routine/widgets/countdown.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/loading_sto_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/tiles/exercise_tile.dart';
import 'package:sculpt/presentation/ui_kit/utils/utils.dart';

class ActiveRoutine extends StatefulWidget {
  final Routine routine;
  const ActiveRoutine({
    super.key,
    required this.routine,
  });

  @override
  State<ActiveRoutine> createState() => _ActiveRoutineState();
}

class _ActiveRoutineState extends State<ActiveRoutine> with TickerProviderStateMixin {
  late RoutineControlCubit cubit;
  late Timer timer;
  bool isFinished = false;

  @override
  void initState() {
    cubit = context.read<RoutineControlCubit>();
    cubit.start(widget.routine);

    super.initState();
  }

  @override
  void dispose() {
    cubit.stop();
    super.dispose();
  }

  Exercise? getNextExercise(int? currentIndex) {
    if (currentIndex == null) {
      return null;
    }

    final nextExerciseIndex = currentIndex + 1;

    if (nextExerciseIndex > widget.routine.exercises.length - 1) {
      return null;
    }

    return widget.routine.exercises[nextExerciseIndex];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineControlCubit, RoutineControlState>(
      listener: (context, state) {
        if (state.event == RoutineEvent.fullyFinished) {
          setState(() {
            isFinished = true;
          });
        }
      },
      builder: (context, state) {
        final exercise = widget.routine.exercises[state.currentExerciseIndex!];
        final nextExercise = getNextExercise(state.currentExerciseIndex);
        if (state.event == RoutineEvent.exerciseFinished) {
          context.read<RoutineControlCubit>().start(widget.routine, newIndex: (state.currentExerciseIndex ?? 0) + 1);
        }

        return Scaffold(
          backgroundColor: UIKitColors.primaryColor,
          appBar: defaultAppBar(
            context,
            "${widget.routine.name} in progress",
            onTap: () => Utils.showAlertDialog(context, "Are you sure you want to stop the routine ?"),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: CountDown(
                          exercise: exercise,
                          isFinished: isFinished,
                          secondsAfter: state.secondsPassed,
                          restType: state.restType,
                        ),
                      ),
                      ExerciseTile(
                        backgroundColor: UIKitColors.green,
                        exercise: exercise,
                        routine: widget.routine,
                      ),
                      const SizedBox(height: 20),
                      if (nextExercise != null)
                        ExerciseTile(
                          exercise: nextExercise,
                          routine: widget.routine,
                        ),
                    ],
                  ),
                ),
              ),
              if (exercise.type == WorkoutType.reps && state.restType == null && !isFinished)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: LoadingStopButton(
                      onTap: () {
                        RestType restType = RestType.between;
                        if (state.currentExercise != null && state.currentExercise!.tried >= exercise.sets!) {
                          restType = RestType.after;
                        }
                        if (state.currentExerciseIndex! <= widget.routine.exercises.length - 1 &&
                            state.currentExercise!.tried <= exercise.sets!) {
                          context.read<RoutineControlCubit>().start(
                                widget.routine,
                                newIndex: state.currentExerciseIndex,
                                restType: restType,
                                currentExercise: state.currentExercise ?? exercise,
                              );
                        } else {
                          setState(() {
                            isFinished = true;
                          });
                        }
                      },
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
