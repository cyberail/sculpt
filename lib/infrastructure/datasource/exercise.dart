import 'package:sculpt/infrastructure/datasource/base.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';

class ExerciseDatasource extends BaseDatasource {
  final IsarDatabase db;

  ExerciseDatasource({required this.db});
}
