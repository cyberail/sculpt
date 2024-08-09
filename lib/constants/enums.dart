enum WorkoutType {
  reps("Sets and reps"),
  time('Time based'),
  timeReps('Timed reps');

  const WorkoutType(this.val);

  final String val;
}

enum StateStatus {
  initial,
  loading,
  success,
  failure,
}
