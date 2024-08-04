import 'package:flutter/material.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/presentation/screens/routine/workout/workout_detail.dart';
import 'package:sculpt/presentation/ui_kit/buttons/icon_button/remove_button.dart';
import 'package:sculpt/presentation/ui_kit/buttons/icon_button/start_button.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTile({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: UIKitColors.secondaryColor,
        border: Border.all(width: 1, color: UIKitColors.white),
        borderRadius: BorderRadius.circular(20),
      ),
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
              const SizedBox(width: 4),
              Text(
                "${exercise.time}m",
                style: const TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
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
    );
  }
}
