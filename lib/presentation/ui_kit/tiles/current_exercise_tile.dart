import 'package:flutter/material.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/presentation/ui_kit/colors/colors.dart';

class CurrentExerciseTile extends StatelessWidget {
  final Exercise exercise;
  final bool isCurrent;
  const CurrentExerciseTile({
    super.key,
    required this.exercise,
    this.isCurrent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCurrent ? UIKitColors.green : null,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: UIKitColors.white),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: UIKitColors.white, fontSize: 20),
                ),
              ),
              Text(
                "Sets: ",
                style: TextStyle(color: UIKitColors.white, fontSize: 18),
              ),
              Text(
                exercise.sets.toString(),
                style: TextStyle(color: UIKitColors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              if (exercise.sets != -1 && exercise.isRepSets)
                Text(
                  "reps: ",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18),
                ),
              if (exercise.isRepSets)
                Text(
                  exercise.reps.toString(),
                  style: TextStyle(color: UIKitColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              if (exercise.sets != -1 && exercise.isTimedReps)
                Text(
                  "Time: ",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18),
                ),
              if (exercise.isTimedReps)
                Text(
                  "${exercise.time * 60}s",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(
              height: 2,
              color: UIKitColors.white,
            ),
          ),
          Row(
            children: [
              if (exercise.repsRestMin != null)
                Text(
                  "Rest between: ",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18),
                ),
              if (exercise.repsRestMin != null)
                Text(
                  "${exercise.repsRestMin! * 60}s",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18),
                ),
              Spacer(),
              if (exercise.restAfterMin != null)
                Text(
                  "Rest after: ",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18),
                ),
              if (exercise.restAfterMin != null)
                Text(
                  "${exercise.restAfterMin! * 60}s",
                  style: TextStyle(color: UIKitColors.white, fontSize: 18),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
