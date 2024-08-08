import 'package:flutter/material.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/models/progress.dart';
import 'package:sculpt/presentation/screens/routine/exercise/exercise_detail.dart';
import 'package:sculpt/presentation/ui_kit/buttons/icon_button/remove_button.dart';
import 'package:sculpt/presentation/ui_kit/buttons/icon_button/start_button.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final ExerciseProgress? progress;
  const ExerciseTile({
    super.key,
    required this.exercise,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 140),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: UIKitColors.secondaryColor,
        border: Border.all(width: 1, color: UIKitColors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          if (progress != null)
            LayoutBuilder(builder: (context, constraints) {
              return Container(
                width: (progress!.currentPercentage / 100) * constraints.maxWidth,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: UIKitColors.green,
                ),
              );
            }),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 5),
                    Text(
                      exercise.name,
                      style: const TextStyle(color: UIKitColors.white, fontSize: 16),
                    ),
                    const Spacer(),
                    UIKitRemoveButton(onTap: () {}),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    UIKitStartButton(onTap: () {}),
                    const SizedBox(width: 4),
                    const Text(
                      "Start",
                      style: TextStyle(color: UIKitColors.white, fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.timelapse_rounded,
                      color: UIKitColors.white,
                      size: 25,
                    ),
                    loadRepetitionInfo(context),
                    const Spacer(),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return ExerciseDetailScreen(
                            exercise: exercise,
                          );
                        })),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          child: Text(
                            "View or update",
                            style: TextStyle(
                              color: UIKitColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget loadRepetitionInfo(BuildContext context) {
    if (exercise.type == WorkoutType.time) {
      return Row(
        children: [
          Text(
            "${exercise.time}m",
            style: const TextStyle(color: UIKitColors.white, fontSize: 16),
          )
        ],
      );
    } else if (exercise.type == WorkoutType.reps) {
      return Column(
        children: [
          Text(
            "${exercise.sets} sets",
            style: const TextStyle(color: UIKitColors.white, fontSize: 16),
          ),
          Text(
            "${exercise.reps} reps",
            style: const TextStyle(color: UIKitColors.white, fontSize: 16),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
