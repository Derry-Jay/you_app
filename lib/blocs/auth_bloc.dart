import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/extensions.dart';
import '../events/auth_state.dart';
import '../events/loaded_state.dart';
import '../events/loading_state.dart';
import '../models/common/reply.dart';
import '../utils/enums.dart';
import '../utils/keys.dart';
import '../utils/methods.dart';
import '../utils/values.dart';

class AuthBloc extends Bloc<AuthState, bool> {
  late BuildContext _buildContext;
  AuthBloc(BuildContext context) : super(false) {
    _buildContext = context;
    on<LoadedState>((event, emit) {
      emit(false);
    });
    on<LoadingState>((event, emit) {
      emit(true);
    });
  }

  BuildContext get context => (navKey.currentState?.context ??
      (wb?.buildOwner?.focusManager.rootScope.context ?? _buildContext));

  void onPasswordSaved(String? password) {
    body['password'] = password;
  }

  void gotoLoginScreen() async {
    (await context.gotoForever('/login')).jot();
  }

  void gotoRegisterScreen() async {
    (await context.gotoForever('/register')).jot();
  }

  void onNameSaved(String? name) {
    body['username'] = name;
  }

  void onEmailSaved(String? email) {
    body['email'] = email;
  }

  void onNameOrEmailSaved(String? namail) {
    final ip = namail?.trimmed ?? '';
    body['email'] = ip.isValidEmail ? ip : '';
    body['username'] = ip.isValidName ? ip : '';
  }

  void login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      loginFormKey.currentState?.save();
      body.jot();
      add(LoadingState());
      final prefs = await sharedPrefs,
          res = (await getDataFromServer<Map<String, dynamic>>('login',
                  isFormData: true, type: HTTPMethodType.post)) ??
              <String, dynamic>{};
      add(LoadedState());
      res.jot();
      body = <String, dynamic>{};
      final rp = Reply.fromMap(res);
      (await context.revealSnackBar(content: rp.message.textWidget()).closed)
          .execute();
      if (rp.isSuccess &&
          await prefs.setString(
              'jwtAccess', res['access_token']?.toString() ?? '')) {
        (await context.gotoForever('/profile')).jot();
      } else {
        'Failure'.jot();
      }
    } else {
      'Invalid Data'.jot();
    }
  }

  void register() async {
    if (registerFormKey.currentState?.validate() ?? false) {
      registerFormKey.currentState?.save();
      body.jot();
      add(LoadingState());
      final res = (await getDataFromServer<Map<String, dynamic>>('register',
              isFormData: true, type: HTTPMethodType.post)) ??
          <String, dynamic>{};
      add(LoadedState());
      '--------------'.jot();
      res.jot();
      body = <String, dynamic>{};
      final rp = Reply.fromMap(res);
      '______________'.jot();
      (await context.revealSnackBar(content: rp.message.textWidget()).closed)
          .execute();
      rp.isSuccess ? (await context.gotoForever('/login')).jot() : doNothing();
    } else {
      'Invalid Data'.jot();
    }
  }

  void logout() async {
    (await 'jwtAccess'.removeLocalStorageKey)
        ? (await context.gotoForever('/login')).jot()
        : doNothing();
  }

  String? validateConfirmPassword(String? password) {
    final ip = password?.trimmed;
    return ip == pwc.text ? null : 'Passwords do not match !!!!';
  }
}
