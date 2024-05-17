import '../models/common/reply.dart';
import 'profile_state.dart';

class ProfileErrorState extends ProfileState {
  final Reply rp;
  ProfileErrorState(this.rp);
  @override
  // TODO: implement props
  List<Object?> get props => [rp.message];
}
