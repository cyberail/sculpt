import 'package:sculpt/infrastructure/datasource/base.dart';
import 'package:sculpt/infrastructure/persistence/isar_database.dart';

class RoutineDatasource extends BaseDatasource {
  final IsarDatabase db;

  RoutineDatasource({required this.db});
}
