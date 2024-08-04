import 'package:sculpt/infrastructure/datasource/base.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

class RoutineDatasource extends BaseDatasource {
  final IsarDatabase db;

  RoutineDatasource({required this.db});

  Routine create(String name) {
    final routine = Routine()..name = name;
    final result = db.create(routine);
    return result;
  }

  // Future<void> create() {

  // }

  // Future<void> delete() {

  // }
}
