import 'password_visibility.dart';

class PasswordVisible extends PasswordVisibility {
  static final PasswordVisible _singleton = PasswordVisible._internal();

  factory PasswordVisible() {
    return _singleton;
  }

  PasswordVisible._internal();
  }
