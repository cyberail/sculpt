part of 'exercise_cubit.dart';

final class ExerciseState {
  final ExerciseEvent event;

  ExerciseState({required this.event});

  ExerciseState copyWith({ExerciseEvent? event}) {
    return ExerciseState(event: event ?? this.event);
  }
}

enum ExerciseEvent {
  initial,

  createLoading,
  createSuccess,
  createFailure,

  getAllLoading,
  getAllSuccess,
  getAllFailure,

  deleteLoading,
  deleteSuccess,
  deleteFailure,
}
