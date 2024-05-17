import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../extensions/extensions.dart';
import '../events/media_pick_event.dart';
import '../events/media_picked.dart';
import '../events/media_unpicked.dart';
import '../utils/enums.dart';
import '../utils/keys.dart';
import '../utils/methods.dart';
import '../utils/values.dart';

class PickMediaBloc extends Bloc<MediaPickEvent, XFile?> {
  late BuildContext _buildContext;

  PickMediaBloc(BuildContext context) : super(null) {
    on<MediaPicked>((event, emit) async {
      emit(await chooseMedium(ImageSource.camera, type: PickType.image));
      context.getProfileBloc(false).pic = state;
    });
    on<MediaUnpicked>((event, emit) async {
      emit(null);
    });
  }

  BuildContext get context => (navKey.currentState?.context ??
      (wb?.buildOwner?.focusManager.rootScope.context ?? _buildContext));

  void pickImage() {
    add(MediaPicked());
  }
}
