import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sculpt/bloc/routine_control/routine_control_cubit.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/datasource/routine.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

part 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  RoutineCubit(RoutineDatasource datasource)
      : _datasource = datasource,
        super(RoutineState(status: StateStatus.initial));

  late final RoutineDatasource _datasource;

  Future<void> create(String name) async {
    if (name.isEmpty) {
      emit(state.copyWith(status: StateStatus.failure));
      return;
    }

    emit(state.copyWith(status: StateStatus.loading));
    try {
      final routine = _datasource.create(name);
      emit(state.copyWith(status: StateStatus.success, routine: routine));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> getById(Routine routine) async {
    try {
      final fetchedRoutine = _datasource.getById(routine);
      if (fetchedRoutine == null) {
        debugPrint("No routine with id of ${routine.id.toString()}");
        emit(state.copyWith(status: StateStatus.failure));
      }
      emit(state.copyWith(status: StateStatus.success, routine: fetchedRoutine));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> deleteExercise(Routine routine, Exercise exercise) async {
    try {
      emit(state.copyWith(event: RoutineStateEvent.deleteExerciseLoading));
      final updateRoutine = _datasource.deleteExercise(routine, exercise);
      emit(state.copyWith(event: RoutineStateEvent.deleteExerciseSuccess, routine: updateRoutine));
    } catch (e) {
      emit(state.copyWith(event: RoutineStateEvent.deleteExerciseFailure));
    }
  }
}
