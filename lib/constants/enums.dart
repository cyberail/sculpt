enum WorkoutType {
  reps("Sets and reps"),
  timeReps('Timed sets'),
  none('none');

  const WorkoutType(this.val);

  final String val;

  static List<WorkoutType> get validValues => [reps, timeReps];
}

enum RestType {
  between,
  after,
}

enum StateStatus {
  initial,
  loading,
  success,
  failure,
}
