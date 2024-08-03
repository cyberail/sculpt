import 'package:isar/isar.dart';
import 'package:sculpt/constants/enums.dart';

part 'workout.g.dart';

@collection
@Name("Workout")
class WorkOut {
  @Name('id')
  Id id = Isar.autoIncrement;

  @Name('name')
  late String name;

  @Name('type')
  @Enumerated(EnumType.name)
  WorkoutType type = WorkoutType.time;

  @Name('time')
  int? time = -1;
}
