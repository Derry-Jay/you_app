import '../../extensions/extensions.dart';

class Profile {
  String email = '', name = '';
  List<String> interests = <String>[];

  Profile();

  Profile.fromJSON(Map<String, dynamic> map) {
    try {
      map.jot();
      name = map['username'].toString();
      email = map['email'].toString();
      interests = List<String>.from(map['interests'] ?? []);
    } catch (e) {
      e.jot();
    }
  }
}
