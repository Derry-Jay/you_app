import 'auth_state.dart';

class LoadedState extends AuthState{
  static final LoadedState _singleton = LoadedState._internal();

  factory LoadedState() {
    return _singleton;
  }

  LoadedState._internal();
}