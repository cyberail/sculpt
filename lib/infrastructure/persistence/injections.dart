import 'package:get_it/get_it.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';

final sl = GetIt.instance;

Future<IsarDatabase> setUpDatabase() async {
  try {
    final db = sl.get<IsarDatabase>();
    return db;
  } catch (e) {
    final db = await IsarDatabase.openIsarDatabase();
    return sl.registerSingleton<IsarDatabase>(IsarDatabase(db: db));
  }
}
