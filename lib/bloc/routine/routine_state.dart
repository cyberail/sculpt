part of 'routine_cubit.dart';

final class RoutineState {
  final StateStatus status;
  final Routine? routine;

  RoutineState({
    required this.status,
    this.routine,
  });

  RoutineState copyWith({
    StateStatus? status,
    Routine? routine,
  }) {
    return RoutineState(
      status: status ?? this.status,
      routine: routine ?? this.routine,
    );
  }
}
