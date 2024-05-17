import 'auth_state.dart';

class LoadingState extends AuthState {
  static final LoadingState _singleton = LoadingState._internal();

  factory LoadingState() {
    return _singleton;
  }

  LoadingState._internal();
}
