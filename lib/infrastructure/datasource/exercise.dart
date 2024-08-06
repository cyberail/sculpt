import 'package:sculpt/infrastructure/datasource/base.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

class ExerciseDatasource extends BaseDatasource {
  final IsarDatabase db;

  ExerciseDatasource({required this.db});

  Exercise create(Routine routine, Exercise exercise) {
    return db.createExercise(routine, exercise);
  }

  Exercise update(Routine routine, Exercise exerciseToUpdate, Exercise exercise) {
    return db.updateExercise(routine, exerciseToUpdate, exercise);
  }

  Exercise delete(Routine routine, Exercise exercise) {
    return db.deleteExercise(routine, exercise);
  }
}
