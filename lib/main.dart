import 'dart:io';

import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import 'app.dart';
import 'models/common/app_config.dart';
import 'models/common/custom_http.dart';
import 'utils/values.dart';

void main() async {
  try {
    wb = WidgetsFlutterBinding.ensureInitialized();
    gc = await 'config'.configFromAsset;
    acf = AppConfig.fromJson(
        ((await 'pubspec.yaml'.loadFromAssets()).getFromYAML() as Object)
                .getEncoded()
                .getDecoded() as Map<String, Object?>? ??
            <String, Object?>{});
    HttpOverrides.global = CustomHttp();
    if (wb?.buildOwner?.debugBuilding ?? true) {
      throw Exception();
    } else {
      runApp(const MyApp());
    }
  } catch (e) {
    e.jot();
  }
}
