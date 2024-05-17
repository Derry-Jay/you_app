import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/auth_bloc.dart';
import '../blocs/password_bloc.dart';
import '../blocs/pick_media_bloc.dart';
import '../blocs/profile_bloc.dart';
import '../blocs/splash_bloc.dart';
import '../extensions/extensions.dart';
import '../views/widgets/common/circular_loader.dart';
import 'enums.dart';
import 'values.dart';

void rollbackOrientations() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

void lockScreenRotation() async {
  await SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeRight,
    // DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
  ]);
}

void showStatusBar() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
}

void hideLoader({Duration? time, LoaderType? type}) {
  void removeLoader() {
    try {
      overlayLoader(time: time, type: type).remove();
    } catch (e) {
      e.jot();
    }
  }

  time.getTimer(removeLoader).cancel();
}

void doNothing() {}

Widget appleDefaultContextBuilder(
    BuildContext context, EditableTextState editableTextState) {
  return CupertinoAdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState);
}

Widget materialDefaultContextBuilder(
    BuildContext context, EditableTextState editableTextState) {
  return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState);
}

OverlayEntry overlayLoader({Duration? time, LoaderType? type}) {
  Widget loaderBuilder(BuildContext context) {
    return Positioned(
        top: 0,
        left: 0,
        width: context.width,
        height: context.height,
        child: Material(
            color: context.theme.primaryColor.withOpacity(0.5),
            child: CircularLoader(
                duration: time,
                loaderType: type,
                color: context.theme.primaryColor)));
  }

  return OverlayEntry(builder: loaderBuilder);
}

String emptyString() => '';

AuthBloc getAuth(BuildContext context) => AuthBloc(context);

SplashBloc getSplash(BuildContext context) => SplashBloc(context);

ProfileBloc getProfile(BuildContext context) => ProfileBloc(context);

PasswordBloc getPassword(BuildContext context) => PasswordBloc(context);

PickMediaBloc getPickMedia(BuildContext context) => PickMediaBloc(context);

Shader getShader(Rect bounds) {
  return LinearGradient(colors: gradientColors, stops: beigeGradientStops)
      .createShader(bounds);
}

bool onBadCertificate(X509Certificate cert, String host, int port) {
  '$host:$port'.jot();
  return true;
}

bool isImagePath(String str) {
  str.jot();
  return str.isImagePath;
}

bool predicate(Route<dynamic> route) {
  route.jot();
  return false;
}

Icon obtainStar(int index) {
  return index.filledStar;
}

Icon obtainStarOutline(int index) {
  return index.outlinedStar;
}

bool isFirstRoute(Route route) {
  route.jot();
  return route.isFirst;
}

bool isActiveRoute(Route route) {
  route.jot();
  return route.isActive;
}

bool isCurrentRoute(Route route) {
  route.jot();
  return route.isCurrent;
}

bool predicate4(Route route) {
  route.jot();
  return route.hasActiveRouteBelow;
}

bool predicate5(Route route) {
  route.jot();
  return route.willHandlePopInternally;
}

double getDoubleData(Map<String, dynamic> data) {
  return (data['data'] as double);
}

bool getBoolData(Map<String, dynamic> data) {
  return (data['data'] as bool);
}

String getData(List<int> values) {
  return base64.encode(values);
}

Uint8List fromIntList(List<int> list) {
  return getData(list).listData;
}

Widget errorBuilder(BuildContext context, Object object, StackTrace? trace) {
  object.jot();
  trace.jot();
  return Icon(Icons.error,
      size: context.height / 16, color: context.theme.secondaryHeaderColor);
}

// Widget getPageLoader(Size size) {
//   return Image.asset('${assetImagePath}loading_trend.gif',
//       width: size.width, fit: BoxFit.fill, height: size.height);
// }

// Widget getPageLoader1(Size size) {
//   return Image.asset('${assetImagePath}loader1.gif',
//       width: size.width, fit: BoxFit.fill, height: size.height);
// }

Widget getImageLoader(BuildContext context, Widget child, int? i, bool flag) {
  i.jot();
  flag.jot();
  return child;
}

// Widget getPlaceHolderNoImage(BuildContext context, String url) {
//   return Image.asset('${assetImagePath}noImage.png',
//       height: context.height / 12.8,
//       width: context.width / 6.4,
//       fit: BoxFit.fill);
// }

Widget getErrorWidget(BuildContext context, Object object, StackTrace? trace) {
  object.jot();
  trace.jot();
  return Text(object.string);
}

// Widget getErrorWidget(BuildContext context, String url, dynamic error) {
//   return Image.asset('${assetImagePath}noImage.png',
//       height: context.height / 12.8,
//       width: context.width / 6.4,
//       fit: BoxFit.fill);
// }

String? validateName(String? name) =>
    (name?.isEmpty ?? true) ? 'Enter a valid Name' : null;

String? validatePassword(String? password) {
  return password != null && password.isValidPassword
      ? null
      : 'Please enter valid password';
}

String? validateEmail(String? email) {
  return email != null && email.isValidEmail
      ? null
      : 'Please enter a valid Email';
}

Future<Uint8List> getBytesFromAsset(String path,
    {int? width, int? height}) async {
  final data = await rootBundle.load(path);
  final codec = await instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width, targetHeight: height);
  final fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<XFile?> chooseMedium(ImageSource source,
    {PickType? type,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    Duration? maxDuration,
    bool? requestFullMetadata,
    CameraDevice? preferredCameraDevice}) async {
  try {
    switch (type) {
      case PickType.image:
        return picker.pickImage(
            source: source,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality,
            requestFullMetadata: requestFullMetadata ?? true,
            preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear);
      case PickType.media:
        return picker.pickMedia(
            maxWidth: maxWidth,
            maxHeight: maxHeight,
            imageQuality: imageQuality,
            requestFullMetadata: requestFullMetadata ?? true);
      case PickType.video:
        return picker.pickVideo(
            source: source,
            maxDuration: maxDuration,
            preferredCameraDevice: preferredCameraDevice ?? CameraDevice.rear);
      default:
        return null;
    }
  } catch (e) {
    e.jot();
    return null;
  }
}

Future<T?> getDataFromServer<T>(String uril,
    {bool? isFormData,
    Options? options,
    HTTPMethodType? type,
    BaseOptions? baseOptions,
    CancelToken? cancelToken}) async {
  try {
    Response<T> res;
    final dio = Dio(baseOptions);
    final isFD = isFormData ?? false;
    final data = isFD ? body : body.formData();
    switch (type) {
      case HTTPMethodType.delete:
        res = await dio.deleteUri<T>(uril.url,
            data: data, options: options, cancelToken: cancelToken);
        break;
      case HTTPMethodType.head:
        res = await dio.headUri<T>(uril.url,
            data: data, options: options, cancelToken: cancelToken);
        break;
      case HTTPMethodType.patch:
        res = await dio.patchUri<T>(
          uril.url,
          data: data,
          options: options,
          cancelToken: cancelToken,
          // onSendProgress: cm.onProgress,
          // onReceiveProgress: cm.onProgress
        );
        break;
      case HTTPMethodType.post:
        res = await dio.postUri<T>(
          uril.url,
          data: data,
          options: options,
          cancelToken: cancelToken,
          // onSendProgress: cm.onProgress,
          // onReceiveProgress: cm.onProgress
        );
        break;
      case HTTPMethodType.put:
        res = await dio.putUri<T>(
          uril.url,
          data: data,
          options: options,
          cancelToken: cancelToken,
          // onSendProgress: cm.onProgress,
          // onReceiveProgress: cm.onProgress
        );
        break;
      default:
        res = await dio.getUri<T>(
          uril.url,
          data: data,
          options: options,
          cancelToken: cancelToken,
          // onReceiveProgress: cm.onProgress
        );
    }
    return res.data;
  } catch (e) {
    e.jot();
    return e is DioException ? e.response?.data : null;
  }
}
