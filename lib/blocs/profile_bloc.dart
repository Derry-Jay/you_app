import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../extensions/extensions.dart';
import '../events/load_profile_event.dart';
import '../events/profile_error_state.dart';
import '../events/profile_event.dart';
import '../events/profile_loaded_state.dart';
import '../events/profile_loading_state.dart';
import '../events/profile_state.dart';
import '../models/auth/profile_base.dart';
import '../models/common/field.dart';
import '../models/common/reply.dart';
import '../utils/enums.dart';
import '../utils/keys.dart';
import '../utils/methods.dart';
import '../utils/values.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late BuildContext _buildContext;

  Gender? gender;

  XFile? pic;

  final fields = <Field>[
    Field('Display name:', FieldType.text, 'Enter name'),
    Field('Gender:', FieldType.dropDown, 'Select Gender'),
    Field('Birthday:', FieldType.text, 'DD MM YYYY'),
    Field('Horoscope:', FieldType.text, '--'),
    Field('Height:', FieldType.text, 'Add height'),
    Field('Weight:', FieldType.text, 'Add weight')
  ];

  ProfileBloc(BuildContext context) : super(ProfileLoadingState()) {
    _buildContext = context;
    on<LoadProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());
      final prefs = await sharedPrefs;
      final token = prefs.getString('jwtAccess');
      token.jot();
      final prof = await getDataFromServer<Map<String, dynamic>>('getProfile',
              options: Options(
                  headers: <String, dynamic>{'x-access-token': token})) ??
          <String, dynamic>{};
      prof.jot();
      final rp = Reply.fromMap(prof);
      final prf = ProfileBase.fromJSON(prof);
      (await bc.revealSnackBar(content: rp.message.textWidget()).closed)
          .execute();
      nmc.text = prf.profile.name;

      emit(rp.isSuccess ? ProfileLoadedState(prf) : ProfileErrorState(rp));
    });
  }

  BuildContext get bc => (navKey.currentState?.context ??
      (wb?.buildOwner?.focusManager.rootScope.context ?? _buildContext));

  void getProfile() {
    add(LoadProfileEvent());
  }

  void onGenderChanged(Gender? g) {
    gender = g;
  }

  void pickDate() async {
    try {
      final dt = await bc.showAllDatePicker();
      dac.text = DateFormat.yMMMd().format(dt!);
    } catch (e) {
      e.jot();
    }
  }

  void updateProfile() async {
    body = {
      'name': nmc.text,
      'birthday': dac.text,
      'height': htc.text.toInt(),
      'weight': wtc.text.toInt(),
      'horoscope': hrc.text
      // 'interests': ['string']
      ,
      'gender': gender?.name
    };
    final res = await getDataFromServer('updateProfile',
        isFormData: true, type: HTTPMethodType.put);
    final rp = Reply.fromMap(res);
    (await bc.revealSnackBar(content: rp.message.textWidget()).closed)
        .execute();
    rp.isSuccess ? bc.goBack() : doNothing();
  }
}
