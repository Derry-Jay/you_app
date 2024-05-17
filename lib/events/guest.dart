import 'confirmation.dart';

class Guest extends Confirmation {
  static final Guest _singleton = Guest._internal();

  factory Guest() {
    return _singleton;
  }

  Guest._internal();
}
