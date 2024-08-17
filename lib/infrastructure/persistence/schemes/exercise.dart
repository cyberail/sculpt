// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import 'package:sculpt/constants/enums.dart';

part 'exercise.g.dart';

@embedded
@Name("Exercise")
class Exercise {
  @Name('name')
  late String name;

  @Name('type')
  @Enumerated(EnumType.name)
  WorkoutType type = WorkoutType.timeReps;

  @Name('time')
  double time = -1;

  @Name('rest_after_min')
  double? restAfterMin = -1;

  @Name('sets')
  int? sets = -1;

  @Name('reps')
  int? reps = -1;

  @Name('reps_rest_min')
  double? repsRestMin = -1;

  @ignore
  int tried = 0;

  Exercise({
    this.name = '',
    this.type = WorkoutType.none,
    this.time = -1,
    this.restAfterMin,
    this.sets,
    this.reps,
    this.repsRestMin,
    this.tried = 0,
  });

  bool get isTimedReps => type == WorkoutType.timeReps;
  bool get isRepSets => type == WorkoutType.reps;

  factory Exercise.clone(Exercise ex) {
    return Exercise(
      name: ex.name,
      type: ex.type,
      time: ex.time,
      tried: ex.tried,
      restAfterMin: ex.restAfterMin,
      sets: ex.sets,
      reps: ex.reps,
      repsRestMin: ex.repsRestMin,
    );
  }

  double getResTimeSeconds(RestType restType) {
    if (restType == RestType.between) return repsRestMin! * 60;

    return restAfterMin! * 60;
  }
}
