import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import 'generated/l10n.dart';
import 'utils/keys.dart';
import 'utils/values.dart';
// import 'views/screens/about/edit_profile_screen.dart';
import 'views/screens/common/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Widget appBuilder(BuildContext context, Widget? child) {
    context.initScreenUtil(minTextAdapt: true, designSize: minDesignSize);
    return MaterialApp(
        home: child,
        title: title,
        theme: css.theme,
        navigatorKey: navKey,
        onGenerateRoute: rg.generateRoute,
        debugShowCheckedModeBanner: kDebugMode,
        supportedLocales: S.delegate.supportedLocales,
        localizationsDelegates: localizationDelegates);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: providers,
        child: ScreenUtilInit(
            minTextAdapt: true,
            builder: appBuilder,
            designSize: minDesignSize,
            child: const SplashScreen()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wb?.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    wb?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    '--------------'.jot();
    state.jot();
    '______________'.jot();
    // switch (state) {
    //   case AppLifecycleState.detached:
    //     break;
    //   default:
    // }
  }
}
