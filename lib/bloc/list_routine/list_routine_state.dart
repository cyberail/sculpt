part of 'list_routine_cubit.dart';

final class ListRoutineState {
  final StateStatus status;
  final List<Routine>? routines;

  ListRoutineState({
    required this.status,
    this.routines,
  });

  ListRoutineState copyWith({
    StateStatus? status,
    List<Routine>? routines,
  }) {
    return ListRoutineState(
      status: status ?? this.status,
      routines: routines ?? this.routines,
    );
  }
}
