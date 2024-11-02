import 'package:sculpt/infrastructure/datasource/base.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

class RoutineDatasource extends BaseDatasource {
  final IsarDatabase db;

  RoutineDatasource({required this.db});

  Routine create(String name) {
    final routine = Routine()..name = name;
    final result = db.create(routine);
    return result;
  }

  List<Routine> getAllRoutines() {
    final result = db.getAllRoutines();
    return result;
  }

  Routine? getById(Routine routine) {
    final result = db.getById(routine.id);
    return result;
  }

  Routine deleteExercise(Routine routine, Exercise exercise) {
    return db.deleteExercise(routine, exercise);
  }

  bool remove(Routine routine) => db.deleteRoutine(routine);

  // Future<void> create() {

  // }

  // Future<void> delete() {

  // }
}
