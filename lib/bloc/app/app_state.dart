// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomAppState {
  final AppStateEnum appState;

  CustomAppState({required this.appState});

  CustomAppState copyWith({
    AppStateEnum? appState,
  }) {
    return CustomAppState(
      appState: appState ?? this.appState,
    );
  }
}

enum AppStateEnum {
  locked,
  active,
}
