import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
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
}
