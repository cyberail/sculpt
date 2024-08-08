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
  WorkoutType type = WorkoutType.time;

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
}
