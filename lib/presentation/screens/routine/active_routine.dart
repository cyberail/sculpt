import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/routine_control/routine_control_cubit.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/screens/routine/widgets/countdown.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
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

  @override
  void initState() {
    cubit = context.read<RoutineControlCubit>();
    cubit.start(widget.routine);
    timer = context.read<RoutineControlCubit>().state.timer!;
    super.initState();
  }

  @override
  void dispose() {
    cubit.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutineControlCubit, RoutineControlState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.event == RoutineEvent.exerciseFinished) {
          context.read<RoutineControlCubit>().start(widget.routine, newIndex: (state.currentExerciseIndex ?? 0) + 1);
        }
        final exercise = widget.routine.exercises[state.currentExerciseIndex!];
        return Scaffold(
          backgroundColor: UIKitColors.primaryColor,
          appBar: defaultAppBar(
            context,
            "${widget.routine.name} in progress",
            onTap: () => Utils.showAlertDialog(context, "Are you sure you want to stop the routine ?"),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: CountDown(
                    exercise: exercise,
                    secondsAfter: state.secondsPassed,
                    restType: state.restType,
                  ),
                ),
                ExerciseTile(
                  exercise: exercise,
                  routine: widget.routine,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
