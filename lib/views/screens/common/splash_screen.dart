import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../utils/values.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: context.width,
            height: context.height,
            decoration: css.screenBackground1,
            child: Center(
                child: title.textWidget(
                    style: 'Inter'.getStyleFromFont(color: shades.kWhite)))));
  }

  @override
  void initState() {
    super.initState();
    wb?.addPostFrameCallback(context.getSplashBloc().setData);
  }
}
