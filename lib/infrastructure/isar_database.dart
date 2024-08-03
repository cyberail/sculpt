import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sculpt/models/workout.dart';

class IsarDatabase {
  Isar db;
  IsarDatabase({required this.db});

  static Future<Isar> openIsarDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([WorkOutSchema], directory: dir.path);
  }
}
