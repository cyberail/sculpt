import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/datasource/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit(ExerciseDatasource datasource)
      : _datasource = datasource,
        super(ExerciseState(event: ExerciseEvent.initial));

  late final ExerciseDatasource _datasource;

  Future<void> create(
    Routine routine, {
    required String name,
    required WorkoutType type,
    double? time = -1,
    int? sets = -1,
    int? reps = -1,
    double? restAfter = -1,
    double? restBetween = -1,
  }) async {
    emit(state.copyWith(event: ExerciseEvent.createLoading));
    try {
      final exercise = Exercise()
        ..name = name
        ..type = type
        ..time = time ?? -1
        ..sets = sets
        ..reps = reps
        ..repsRestMin = restBetween
        ..restAfterMin = restAfter;

      _datasource.create(routine, exercise);

      emit(state.copyWith(event: ExerciseEvent.createSuccess));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(event: ExerciseEvent.createFailure));
    }
  }

  Future<void> update(
    Routine routine,
    Exercise exerciseToUpdate, {
    required String name,
    required WorkoutType type,
    double? time = -1,
    int? sets = -1,
    int? reps = -1,
    double? restAfter = -1,
    double? restBetween = -1,
  }) async {
    throw UnimplementedError();
  }

  // Future<void> getAll() {}
}
