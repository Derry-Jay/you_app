import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../utils/values.dart';

class Css {
  static final Css _singleton = Css._internal();

  factory Css() => _singleton;

  Css._internal();

  final profileNameStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          fontWeight: 700.fontWeight,
          fontSize: measurements.large,
          letterSpacing: measurements.profileLetterSpacing,
          height: measurements.themedButtonLabelLineHeight),
      profileHeaderStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          fontWeight: 600.fontWeight,
          fontSize: measurements.medium,
          height: measurements.interestAndAboutLineHeight),
      interestAndAboutStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite2,
          fontWeight: 500.fontWeight,
          fontSize: measurements.normal,
          height: measurements.interestAndAboutLineHeight),
      textFieldInputStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          fontWeight: 500.fontWeight,
          height: measurements.bottomTextLineHeight,
          fontSize: (measurements.medium + measurements.normal) / 2),
      aboutFieldLabelStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite6,
          fontWeight: 500.fontWeight,
          height: measurements.bottomTextLineHeight,
          fontSize: (measurements.medium + measurements.normal) / 2),
      aboutAndInterestDecoration = BoxDecoration(
          color: shades.kBlack3,
          borderRadius:
              measurements.aboutAndInterestBorderRadius.circularRadius.all),
      aboutAndInterestInputStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite4,
          fontWeight: 500.fontWeight,
          fontSize: measurements.medium,
          height: measurements.interestAndAboutLineHeight),
      aboutAndInterestHintStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite4,
          fontWeight: 500.fontWeight,
          height: measurements.bottomTextLineHeight,
          fontSize: (measurements.medium + measurements.normal) / 2),
      backStyle = 'Inter'.getStyleFromFont(color: shades.kWhite),
      cupertinoFieldPlaceHolderStyleDefault =
          const TextStyle(color: CupertinoColors.placeholderText),
      profileNameDecoration = BoxDecoration(
          color: shades.kBlack4,
          borderRadius: measurements.themedButtonRadius.circularRadius.all),
      addPicDecoration = BoxDecoration(
          color: shades.kWhite5,
          borderRadius: measurements.aboutPicRadius.circularRadius.all),
      aboutAndInterestHeadingStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          fontWeight: 700.fontWeight,
          fontSize: measurements.medium,
          height: measurements.interestAndAboutLineHeight),
      authHeadingStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          fontWeight: 700.fontWeight,
          fontSize: measurements.xl4,
          height: measurements.authHeadingLineHeight),
      bottomTextStyle1 = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          height: measurements.bottomTextLineHeight,
          fontSize: (measurements.medium + measurements.normal) / 2),
      saveAndCloseStyle = 'Inter'.getStyleFromFont(
          fontWeight: 500.fontWeight,
          fontSize: measurements.normal,
          foreground: paint..shader = gradientShader,
          height: measurements.saveAndCloseLineHeight),
      bottomTextStyle2 = 'Inter'.getStyleFromFont(
          fontWeight: 500.fontWeight,
          decorationColor: shades.kBrown4,
          decoration: TextDecoration.underline,
          height: measurements.bottomTextLineHeight,
          foreground: paint..shader = gradientShader,
          fontSize: (measurements.medium + measurements.normal) / 2),
      themedButtonStyle = OutlinedButton.styleFrom(
          fixedSize: Size(
              measurements.themedButtonWidth, measurements.themedButtonHeight),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: shades.kTransparent),
              borderRadius:
                  measurements.themedButtonRadius.circularBorderRadius)),
      themedButtonLabelStyle = 'Inter'.getStyleFromFont(
          color: shades.kWhite,
          fontWeight: 700.fontWeight,
          fontSize: measurements.large,
          height: measurements.themedButtonLabelLineHeight),
      themedButtonDecoration = BoxDecoration(
        border: Border.all(color: shades.kTransparent),
        gradient: LinearGradient(colors: [shades.kCyan1, shades.kBlue1]),
        borderRadius: measurements.themedButtonRadius.circularRadius.all,
      ),
      screenBackground1 = BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              stops: screenBackgroundStops,
              colors: [shades.kBlack1, shades.kBlack2, shades.kGrey2])),
      screenBackground2 = BoxDecoration(color: shades.kBlack1),
      screenBackground3 = BoxDecoration(color: shades.kBlack3),
      theme = ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run"
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: shades.kBlue,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: shades.kWhite1,
              hintStyle: 'Inter'.getStyleFromFont(color: shades.kWhite1),
              helperStyle: 'Inter'.getStyleFromFont(color: shades.kWhite1),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: shades.kTransparent),
                  borderRadius:
                      measurements.textFieldRadius.circularRadius.all),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: shades.kTransparent),
                  borderRadius:
                      measurements.textFieldRadius.circularRadius.all),
              border: OutlineInputBorder(borderSide: BorderSide(color: shades.kTransparent), borderRadius: measurements.textFieldRadius.circularRadius.all)));
}
