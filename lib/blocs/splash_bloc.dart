import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_app/extensions/extensions.dart';

import '../events/authenticated.dart';
import '../events/confirmation.dart';
import '../events/guest.dart';
import '../utils/keys.dart';
import '../utils/values.dart';

class SplashBloc extends Bloc<Confirmation, bool> {
  late BuildContext _buildContext;
  SplashBloc(BuildContext context) : super(false) {
    _buildContext = context;
    on<Guest>((event, emit) {
      emit(false);
    });
    on<Authenticated>((event, emit) {
      emit(true);
    });
  }

  BuildContext get bc => (navKey.currentState?.context ??
      (wb?.buildOwner?.focusManager.rootScope.context ?? _buildContext));

  void setData(Duration time) async {
    await Future.delayed(
        <int>[2, 3].contains(time.inSeconds)
            ? time
            : Duration(seconds: splashScreenDelay),
        nextScreen);
  }

  FutureOr nextScreen() async {
    final prefs = await sharedPrefs;
    return bc.gotoForever(
        '/${prefs.containsKey("jwtAccess") ? "profile" : "login"}');
  }
}
