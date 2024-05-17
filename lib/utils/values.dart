import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodiac/zodiac.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/password_bloc.dart';
import '../blocs/pick_media_bloc.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/splash_bloc.dart';
import '../css/assets.dart';
import '../css/css.dart';
import '../css/measurements.dart';
import '../css/shades.dart';
import '../extensions/extensions.dart';
import '../generated/l10n.dart';
import '../models/common/app_config.dart';
import '../models/common/progress.dart';
import 'enums.dart';
import 'methods.dart';
import 'my_geocoder.dart';
import 'my_geolocator.dart';
import 'my_local_authentication.dart';
import 'route_generator.dart';

int page = 0;

WidgetsBinding? wb;

bool hideText = true;

GlobalConfiguration? gc;

AppConfig acf = AppConfig();

DateTime? currentBackPressTime;

StreamSubscription<Progress>? ssc;

Map<String, dynamic> body = <String, dynamic>{};

const apiMode =
        kDebugMode ? APIMode.dev : (kProfileMode ? APIMode.test : APIMode.prod),
    rect = Rect.fromLTWH(0.0, 0.0, 165, 16),
    screenBackgroundStops = [0.65, 0.75, 0.85],
    beigeGradientStops = [-0.068, 0.1676, 0.305, 0.496, 0.7856, 0.8901, 1.0043];

final css = Css(),
    zdc = Zodiac(),
    paint = Paint(),
    st = Stopwatch(),
    assets = Assets(),
    shades = Shades(),
    gco = MyGeocoder(),
    gl = MyGeolocator(),
    conn = Connectivity(),
    picker = ImagePicker(),
    today = DateTime.now(),
    isIOS = Platform.isIOS,
    fmd1 = DateFormat.MMMd(),
    isMac = Platform.isMacOS,
    dip = DeviceInfoPlugin(),
    isLinux = Platform.isLinux,
    tgr = TapGestureRecognizer(),
    la = MyLocalAuthentication(),
    thisMoment = TimeOfDay.now(),
    sc = TextEditingController(),
    tc = TextEditingController(),
    isCupertino = isIOS || isMac,
    measurements = Measurements(),
    wtc = TextEditingController(),
    hrc = TextEditingController(),
    htc = TextEditingController(),
    pwc = TextEditingController(),
    nmc = TextEditingController(),
    dac = TextEditingController(),
    isAndroid = Platform.isAndroid,
    isWindows = Platform.isWindows,
    isFuchsia = Platform.isFuchsia,
    rg = RouteGenerator(flag: true),
    isPortable = isAndroid || isIOS,
    polylinePoints = PolylinePoints(),
    minDesignSize = const Size(375, 812),
    title = gc?.getValue<String>('name') ?? '',
    sharedPrefs = SharedPreferences.getInstance(),
    gradientShader = myLinearGradient.createShader(rect),
    myLinearGradient =
        LinearGradient(colors: gradientColors, stops: beigeGradientStops),
    splashScreenDelay =
        gc?.getValue<String>('splash_screen_delay').toInt(null, 3) ?? 3,
    minPwdLth =
        gc?.getValue<String>('minimum_password_length').toInt(null, 8) ?? 8,
    minimumUserNameLength =
        gc?.getValue<String>('minimum_user_name_length').toInt(null, 3) ?? 3,
    maxPwdLth =
        gc?.getValue<String>('maximum_password_length').toInt(null, 16) ?? 16,
    isWeb = !(isAndroid || isCupertino || isWindows || isLinux || isFuchsia) &&
        kIsWeb,
    spaceExp = RegExp(r'\s'),
    nameExp = RegExp(r"^[\\p{L} .'-]+$"),
    pwdExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$'),
    mailExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"),
    providers = const <SingleChildWidget>[
      BlocProvider<AuthBloc>(create: getAuth),
      BlocProvider<SplashBloc>(create: getSplash),
      BlocProvider<ProfileBloc>(create: getProfile),
      BlocProvider<PasswordBloc>(create: getPassword),
      BlocProvider<PickMediaBloc>(create: getPickMedia)
    ],
    localizationDelegates = const <LocalizationsDelegate<dynamic>>[
      S.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate
    ],
    gradientColors = <Color>[
      shades.kBrown5,
      shades.kBrown2,
      shades.kBrown1,
      shades.kBrown3,
      shades.kBrown4,
      shades.kBrown1,
      shades.kBrown4
    ];
