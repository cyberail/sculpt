import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:sculpt/constants/enums.dart';
import 'package:sculpt/infrastructure/datasource/routine.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

part 'list_routine_state.dart';

class ListRoutineCubit extends Cubit<ListRoutineState> {
  ListRoutineCubit(RoutineDatasource datasource)
      : _datasource = datasource,
        super(ListRoutineState(status: StateStatus.initial));

  late final RoutineDatasource _datasource;

  Future<void> getAll() async {
    try {
      final routines = _datasource.getAllRoutines();
      emit(state.copyWith(status: StateStatus.success, routines: routines));
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
      // emit(state.copyWith(status: StateStatus.success, routine: fetchedRoutine));
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: StateStatus.failure));
    }
  }
}
