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
      padding: EdgeInsets.all(20),
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
              Text(
                exercise.name,
                style: TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
              Spacer(),
              UIKitRemoveButton(onTap: () {}),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              UIKitStartButton(onTap: () {}),
              const SizedBox(width: 4),
              Text(
                "Start",
                style: TextStyle(color: UIKitColors.white, fontSize: 14),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.timelapse_rounded,
                color: UIKitColors.white,
                size: 25,
              ),
              SizedBox(width: 4),
              Text(
                "${exercise.time}m",
                style: TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
              Spacer(),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return ExerciseDetailScreen(
                    exercise: exercise,
                  );
                })),
                child: Text(
                  "View or update",
                  style: TextStyle(
                    color: UIKitColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
