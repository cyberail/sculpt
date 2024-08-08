part of 'routine_control_cubit.dart';

class RoutineControlState {
  final Routine? routine;
  final RoutineStatus status;
  final RoutineEvent? event;
  final Timer? timer;
  Exercise? currentExercise;
  int secondsPassed;

  RoutineControlState({
    this.routine,
    this.status = RoutineStatus.initial,
    this.event,
    this.timer,
    this.currentExercise,
    this.secondsPassed = 0,
  });

  RoutineControlState copyWith({
    Routine? routine,
    RoutineStatus? status,
    RoutineEvent? event,
    Timer? timer,
    Exercise? currentExercise,
    int? secondsPassed,
  }) {
    return RoutineControlState(
      routine: routine ?? this.routine,
      status: status ?? this.status,
      event: event ?? this.event,
      timer: timer ?? this.timer,
      currentExercise: currentExercise ?? this.currentExercise,
      secondsPassed: secondsPassed ?? this.secondsPassed,
    );
  }
}

enum RoutineStatus {
  initial,
  playing,
  paused,
}

enum RoutineEvent {
  started,
  stopped,
  paused,
  tick,
}
