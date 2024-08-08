import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sculpt/infrastructure/datasource/routine.dart';
import 'package:sculpt/infrastructure/persistence/schemes/exercise.dart';
import 'package:sculpt/infrastructure/persistence/schemes/routine.dart';

part 'routine_control_state.dart.dart';

class RoutineControlCubit extends Cubit<RoutineControlState> {
  RoutineControlCubit({required RoutineDatasource datasource})
      : _datasource = datasource,
        super(RoutineControlState());

  late final RoutineDatasource _datasource;

  void start(Routine routine) async {
    emit(state.copyWith(routine: routine));
    if (state.timer != null) {
      state.timer?.cancel();
    }
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(
        event: RoutineEvent.tick,
        secondsPassed: state.secondsPassed += 1,
      ));
      if (state.secondsPassed == state.currentExercise!.time * 60) {
        state.timer?.cancel();
      }
    });
    emit(state.copyWith(
      status: RoutineStatus.playing,
      event: RoutineEvent.started,
      timer: timer,
      currentExercise: state.routine?.exercises[0],
    ));
  }

  Future<void> stop() async {
    if (state.timer != null) {
      state.timer?.cancel();
      emit(
        RoutineControlState(
          routine: state.routine,
          event: RoutineEvent.stopped,
          status: RoutineStatus.initial,
          timer: null,
        ),
      );
    }
  }
}
