part of 'routine_control_cubit.dart';

class RoutineControlState {
  final Routine? routine;
  final RoutineStatus status;
  final RoutineEvent? event;
  final Timer? timer;
  int? currentExerciseIndex;
  int secondsPassed;
  RestType? restType;

  RoutineControlState({
    this.routine,
    this.status = RoutineStatus.initial,
    this.event,
    this.timer,
    this.currentExerciseIndex,
    this.secondsPassed = 0,
    this.restType,
  });

  RoutineControlState copyWith({
    Routine? routine,
    RoutineStatus? status,
    RoutineEvent? event,
    Timer? timer,
    int? currentExerciseIndex,
    int? secondsPassed,
    RestType? restType,
  }) {
    return RoutineControlState(
      routine: routine ?? this.routine,
      status: status ?? this.status,
      event: event ?? this.event,
      timer: timer,
      restType: restType,
      currentExerciseIndex: currentExerciseIndex ?? this.currentExerciseIndex,
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
  exerciseFinished,
}
