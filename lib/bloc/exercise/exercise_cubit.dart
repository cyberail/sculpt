import 'package:bloc/bloc.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit() : super(ExerciseState());
}
