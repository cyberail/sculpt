// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';

class ExerciseProgress {
  final int? currentSeconds;
  final double? currentSet;
  final Exercise exercise;
  final RestType? restType;

  ExerciseProgress({
    required this.exercise,
    this.currentSeconds,
    this.currentSet,
    this.restType,
  });

  double get currentPercentage {
    if (exercise.type == WorkoutType.time || exercise.type == WorkoutType.timeReps) {
      return timePercentage();
    } else {
      if (restType == RestType.after) {
        return (currentSeconds! / (exercise.restAfterMin! * 60)) * 100;
      } else if (restType == RestType.between) {
        return (currentSeconds! / (exercise.repsRestMin! * 60)) * 100;
      }
      return repsPercentage();
    }
  }

  double get totalSeconds {
    if (restType == null) return exercise.time * 60;
    if (restType == RestType.after) {
      return exercise.restAfterMin! * 60;
    } else {
      return exercise.repsRestMin! * 60;
    }
  }

  double timePercentage() {
    if (currentSeconds == null || exercise.time == -1) return 0;

    return (currentSeconds! / totalSeconds) * 100;
  }

  double repsPercentage() {
    if (exercise.reps == null || exercise.sets == null || currentSet == null) {
      return 0;
    }
    return (currentSet! / exercise.sets!) * 100;
  }
}
