import 'password_visibility.dart';

class PasswordInvisible extends PasswordVisibility{
  static final PasswordInvisible _singleton = PasswordInvisible._internal();

  factory PasswordInvisible() {
    return _singleton;
  }

  PasswordInvisible._internal();
}