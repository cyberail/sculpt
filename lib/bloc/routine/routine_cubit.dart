import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'routine_state.dart';

class RoutineCubit extends Cubit<RoutineState> {
  RoutineCubit() : super(RoutineInitial());
}
