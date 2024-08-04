import 'package:isar/isar.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';

part 'routine.g.dart';

@collection
@Name("Routine")
class Routine {
  @Name("id")
  Id id = Isar.autoIncrement;

  @Name("name")
  String name = "";

  @Name("exercises")
  List<Exercise> exercises = [];

  double getDurationSum() {
    double result = 0;
    for (var exercise in exercises) {
      if (exercise.time == -1) {
        continue;
      }

      result += exercise.time;
    }

    return result;
  }
}
