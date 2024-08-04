import 'package:flutter/material.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/ui_kit/app_bar/default_appbar.dart';
import 'package:sculpt/presentation/ui_kit/buttons/floating_addition_btn.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';
import 'package:sculpt/presentation/ui_kit/errors/empty.dart';
import 'package:sculpt/presentation/ui_kit/tiles/exercise_tile.dart';

class RoutineDetailScreen extends StatelessWidget {
  final Routine routine;
  RoutineDetailScreen({super.key, required this.routine}) {
    routine.exercises.clear();
    final ex = Exercise()
      ..name = "Deadlift"
      ..time = 23
      ..type = WorkoutType.time;
    final ex2 = Exercise()
      ..name = "Leg press"
      ..time = 12
      ..type = WorkoutType.time;
    routine.exercises.addAll([ex, ex2]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIKitColors.primaryColor,
      appBar: defaultAppBar(context, "Routine: ${routine?.name} "),
      floatingActionButton: FloatingAdditionButton(onTap: () {}),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: _checkAndBuild(),
      ),
    );
  }

  Widget _checkAndBuild() {
    if (routine.exercises.isEmpty) {
      return const EmptyListMessage(
        title: "There are no exercises in this routine.",
        subtitle: "Add by tapping the add button.",
      );
    }
    return ListView(children: [
      ...routine.exercises.map((exercise) {
        return Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: ExerciseTile(exercise: exercise));
      })
    ]);
  }
}
