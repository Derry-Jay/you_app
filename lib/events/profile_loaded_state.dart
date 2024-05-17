import '../models/auth/profile_base.dart';
import 'profile_state.dart';

class ProfileLoadedState extends ProfileState {
  final ProfileBase pb;
  ProfileLoadedState(this.pb);
  @override
  // TODO: implement props
  List<Object?> get props => [pb.profile];
}
