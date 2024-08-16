import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sculpt/bloc/app/app_state.dart';

class AppCubit extends Cubit<CustomAppState> {
  AppCubit() : super(CustomAppState(appState: AppStateEnum.active));

  void lock() async {
    emit(state.copyWith(appState: AppStateEnum.active));
  }

  void unlock() async {
    emit(state.copyWith(appState: AppStateEnum.active));
  }
}
