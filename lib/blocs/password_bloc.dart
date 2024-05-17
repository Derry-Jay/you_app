import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/password_invisible.dart';
import '../events/password_visibility.dart';
import '../events/password_visible.dart';
import '../utils/keys.dart';
import '../utils/values.dart';

class PasswordBloc extends Bloc<PasswordVisibility, bool> {
  late BuildContext _buildContext;
  PasswordBloc(BuildContext context) : super(true) {
    _buildContext = context;
    on<PasswordVisible>((event, emit) {
      emit(false);
    });
    on<PasswordInvisible>((event, emit) {
      emit(true);
    });
  }

  BuildContext get bc => (navKey.currentState?.context ??
      (wb?.buildOwner?.focusManager.rootScope.context ?? _buildContext));

  void hideShowPassword() {
    add(state ? PasswordVisible() : PasswordInvisible());
  }
}
