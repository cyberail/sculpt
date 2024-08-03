import 'package:flutter/material.dart';
import 'package:sculpt/models/workout.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class RoutineTile extends StatelessWidget {
  final String name;
  final double timeMinutes;

  final List<WorkOut> exercises;
  const RoutineTile({
    super.key,
    required this.name,
    required this.timeMinutes,
    required this.exercises,
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
                name,
                style: TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
              Spacer(),
              Icon(
                Icons.timelapse_rounded,
                color: UIKitColors.white,
                size: 25,
              ),
              SizedBox(width: 4),
              Text(
                "${timeMinutes}m",
                style: TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Icon(
                Icons.fitness_center,
                color: UIKitColors.white,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                "${exercises.length} exercises",
                style: TextStyle(color: UIKitColors.white, fontSize: 14),
              ),
            ],
          )
        ],
      ),
    );
  }
}
