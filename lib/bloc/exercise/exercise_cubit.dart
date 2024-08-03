import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseInitial());
}
