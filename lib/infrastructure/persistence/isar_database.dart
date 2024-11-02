import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

class IsarDatabase {
  Isar db;
  IsarDatabase({required this.db});

  static Future<Isar> openIsarDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([RoutineSchema], directory: dir.path);
  }

  Routine create(Routine routine) {
    db.writeTxnSync(() {
      db.routines.putSync(routine);
    });

    return routine;
  }

  Routine? getById(Id id) {
    final routine = db.routines.getSync(id);

    return routine;
  }

  Exercise createExercise(Routine routine, Exercise exercise) {
    db.writeTxnSync(() {
      routine.exercises = routine.exercises.toList();
      routine.exercises.add(exercise);
      db.routines.putSync(routine);
    });

    return exercise;
  }

  Exercise updateExercise(Routine routine, Exercise exerciseToUpdate, Exercise exercise) {
    db.writeTxnSync(() {
      routine.exercises.removeWhere((element) => element == exerciseToUpdate);
      routine.exercises.add(exercise);
      db.routines.putSync(routine);
    });

    return exercise;
  }

  Routine deleteExercise(Routine routine, Exercise exercise) {
    db.writeTxnSync(() {
      routine.exercises = routine.exercises.toList();
      routine.exercises.removeWhere((element) => element == exercise);
      db.routines.putSync(routine);
    });

    return routine;
  }

  List<Routine> getAllRoutines() {
    final routines = db.routines.where().findAllSync();

    return routines;
  }

  bool deleteRoutine(Routine routine) {
    bool result = false;
    db.writeTxnSync(() {
      result = db.routines.deleteSync(routine.id);
    });

    return result;
  }
}
