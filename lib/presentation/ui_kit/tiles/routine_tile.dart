import 'package:flutter/material.dart';
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
              Text(
                routine.name,
                style: const TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              const Icon(
                Icons.fitness_center,
                color: UIKitColors.white,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                "${routine.exercises.length} Excs",
                style: const TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.timelapse_rounded,
                color: UIKitColors.white,
                size: 25,
              ),
              const SizedBox(width: 4),
              Text(
                "${routine.getDurationSum()} min",
                style: const TextStyle(color: UIKitColors.white, fontSize: 16),
              ),
              const Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  splashFactory: InkSplash.splashFactory,
                  radius: 100,
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return RoutineDetailScreen(
                      routine: routine,
                    );
                  })),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      "View more",
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
