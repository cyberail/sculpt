enum WorkoutType {
  reps("Sets and reps"),
  time('Time based'),
  timeReps('Timed sets'),

  none('none');

  const WorkoutType(this.val);

  final String val;
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
