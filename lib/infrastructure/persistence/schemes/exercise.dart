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
}
