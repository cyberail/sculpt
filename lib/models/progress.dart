// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:core';

import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';

class ExerciseProgress {
  final double? currentSeconds;
  final double? currentSet;
  final Exercise exercise;

  ExerciseProgress({
    required this.exercise,
    this.currentSeconds,
    this.currentSet,
  });

  double get currentPercentage {
    if (exercise.type == WorkoutType.time) {
      return timePercentage();
    } else {
      return repsPercentage();
    }
  }

  double timePercentage() {
    if (currentSeconds == null || exercise.time == -1) return 0;
    final seconds = exercise.time * 60;

    return (currentSeconds! / seconds) * 100;
  }

  double repsPercentage() {
    if (exercise.reps == null || exercise.sets == null || currentSet == null) {
      return 0;
    }
    return (currentSet! / exercise.sets!) * 100;
  }
}
