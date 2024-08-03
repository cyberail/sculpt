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
      decoration: BoxDecoration(
        color: UIKitColors.secondaryColor,
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(color: UIKitColors.white),
          ),
          Column(
            children: [],
          ),
        ],
      ),
    );
  }
}
