import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';
import 'package:sculpt/presentation/screens/routine/routine_detail.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class RoutineTile extends StatelessWidget {
  final Routine routine;

  const RoutineTile({
    super.key,
    required this.routine,
  });

  //test comment
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
                routine.name,
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
                "${routine.getDurationSum()}m",
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
                "${routine.exercises.length} exercises",
                style: TextStyle(color: UIKitColors.white, fontSize: 14),
              ),
              Spacer(),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return RoutineDetailScreen(
                    routine: routine,
                  );
                })),
                child: Text(
                  "View more",
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
