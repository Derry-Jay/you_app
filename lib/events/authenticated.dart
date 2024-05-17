import 'confirmation.dart';

class Authenticated extends Confirmation{
  static final Authenticated _singleton = Authenticated._internal();

  factory Authenticated() {
    return _singleton;
  }

  Authenticated._internal();
}