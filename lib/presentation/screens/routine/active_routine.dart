import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/routine_control/routine_control_cubit.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/event_manager/bus.dart';
import 'package:sculpt/infrastructure/event_manager/evnets.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/screens/routine/widgets/countdown.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/loading_sto_btn.dart';
import 'package:sculpt/presentation/ui_kit/buttons/resizable_floating_button.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/tiles/current_exercise_tile.dart';
import 'package:sculpt/presentation/ui_kit/utils/utils.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class ActiveRoutine extends StatefulWidget {
  final Routine routine;
  final int? index;
  const ActiveRoutine({
    super.key,
    required this.routine,
    this.index,
  });

  @override
  State<ActiveRoutine> createState() => _ActiveRoutineState();
}

class _ActiveRoutineState extends State<ActiveRoutine> with TickerProviderStateMixin {
  late RoutineControlCubit cubit;
  late Timer timer;
  bool isFinished = false;
  bool isLocked = false;

  @override
  void initState() {
    Buss().eventBus.on().listen((event) {
      print("eventBus");
    });
    WakelockPlus.enable();

    cubit = context.read<RoutineControlCubit>();
    cubit.start(widget.routine, newIndex: widget.index);

    super.initState();
  }

  @override
  void dispose() {
    cubit.stop();
    // The next line disables the wakelock again.
    WakelockPlus.disable();
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
        // Buss.eventBus?.on().listen((event) {
        //   print("eventBus");
        // });
        // Buss.eventBus?.on<StopEvent>().listen((event) {
        //   _stop(context, state, widget.routine.exercises[state.currentExerciseIndex!]);
        // });
        final exercise = widget.routine.exercises[state.currentExerciseIndex!];
        final nextExercise = getNextExercise(state.currentExerciseIndex);
        if (state.event == RoutineEvent.exerciseFinished) {
          context.read<RoutineControlCubit>().start(widget.routine, newIndex: (state.currentExerciseIndex ?? 0) + 1);
        }

        return Scaffold(
          backgroundColor: UIKitColors.primaryColor,
          appBar: defaultAppBar(context, "${widget.routine.name} in progress",
              onTap: () => Utils.showAlertDialog(context, "Are you sure you want to stop the routine ?"),
              icon: Icons.close,
              enableBackButton: !isLocked,
              rightSideWidget: IconButton(
                  onPressed: () {
                    setState(() {
                      isLocked = !isLocked;
                    });
                  },
                  icon: Icon(isLocked ? Icons.lock_rounded : Icons.lock_open_rounded))),
          body: Stack(
            children: [
              Padding(
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
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            CurrentExerciseTile(
                              exercise: state.currentExercise ?? exercise,
                              isCurrent: true,
                            ),
                            const SizedBox(height: 20),
                            if (nextExercise != null)
                              CurrentExerciseTile(
                                exercise: nextExercise,
                              ),
                            SizedBox(height: 120),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (exercise.type == WorkoutType.reps && state.restType == null && !isFinished)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: LoadingStopButton(
                      onDoubleTap: isLocked ? () => _stop(context, state, exercise) : null,
                      onTap: !isLocked ? () => _stop(context, state, exercise) : () {},
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ResizableFloatingButton(
                    iconSize: 20,
                    icon: Icons.restart_alt,
                    color: UIKitColors.green,
                    onDoubleTap: isLocked ? () => _restartSet(context, state) : null,
                    onTap: !isLocked ? () => _restartSet(context, state) : () {},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ResizableFloatingButton(
                    iconSize: 20,
                    icon: Icons.replay_outlined,
                    color: UIKitColors.green,
                    onDoubleTap: isLocked ? () => _restartExercise(context, state) : null,
                    onTap: !isLocked ? () => _restartExercise(context, state) : () {},
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _stop(BuildContext context, RoutineControlState state, Exercise exercise) {
    cubit.playFinishSound();
    RestType restType = RestType.between;
    if (state.currentExercise != null && state.currentExercise!.tried >= exercise.sets!) {
      restType = RestType.after;
    }

    if (state.currentExerciseIndex! == widget.routine.exercises.length - 1 &&
        state.currentExercise!.tried == exercise.sets!) {
      setState(() {
        isFinished = true;
      });
      return;
    }

    if (state.currentExerciseIndex! <= widget.routine.exercises.length - 1 &&
        state.currentExercise!.tried <= exercise.sets!) {
      context.read<RoutineControlCubit>().start(
            widget.routine,
            newIndex: state.currentExerciseIndex,
            restType: restType,
            currentExercise: state.currentExercise ?? exercise,
          );
    }
  }

  _restartSet(BuildContext context, RoutineControlState state) {
    context.read<RoutineControlCubit>().restartSet(state.currentExercise?.tried);
  }

  _restartExercise(BuildContext context, RoutineControlState state) {
    context.read<RoutineControlCubit>().restartSet(
          state.currentExercise?.tried,
          restartExercise: true,
        );
  }
}
