import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/routine_control/routine_control_cubit.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/screens/routine/widgets/countdown.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

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
        return Scaffold(
          backgroundColor: UIKitColors.primaryColor,
          appBar: defaultAppBar(
            context,
            "${widget.routine.name} in progress",
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: CountDown(
                    exercise: state.currentExercise!,
                    secondsAfter: state.secondsPassed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
