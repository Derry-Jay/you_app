import '../../extensions/extensions.dart';
import 'profile.dart';

class ProfileBase {
  String message = '';
  Profile profile = Profile();

  ProfileBase();

  ProfileBase.fromJSON(Map<String, dynamic> map) {
    try {
      map.jot();
      message = map['message'].toString();
      profile = Profile.fromJSON(map['data']);
    } catch (e) {
      e.jot();
    }
  }
}
