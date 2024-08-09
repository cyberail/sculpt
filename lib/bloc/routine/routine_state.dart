part of 'routine_cubit.dart';

final class RoutineState {
  final StateStatus status;
  final Routine? routine;
  final RoutineStateEvent? event;

  RoutineState({
    required this.status,
    this.routine,
    this.event = RoutineStateEvent.initial,
  });

  RoutineState copyWith({
    StateStatus? status,
    Routine? routine,
    RoutineStateEvent? event,
  }) {
    return RoutineState(
      status: status ?? this.status,
      routine: routine ?? this.routine,
      event: event ?? this.event,
    );
  }
}

enum RoutineStateEvent {
  initial,

  deleteExerciseLoading,
  deleteExerciseSuccess,
  deleteExerciseFailure,
}
