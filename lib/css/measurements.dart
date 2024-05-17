import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../extensions/extensions.dart';
import '../utils/values.dart';

class Measurements {
  static final Measurements _singleton = Measurements._internal();

  factory Measurements() => _singleton;

  Measurements._internal();

  final xs = gc?.getValue<String>('xs').toInt().sp ?? double.nan,
      xl = gc?.getValue<String>('xl').toInt().sp ?? double.nan,
      xs2 = gc?.getValue<String>('2xs').toInt().sp ?? double.nan,
      xs3 = gc?.getValue<String>('3xs').toInt().sp ?? double.nan,
      xs4 = gc?.getValue<String>('4xs').toInt().sp ?? double.nan,
      xl2 = gc?.getValue<String>('2xl').toInt().sp ?? double.nan,
      xl3 = gc?.getValue<String>('3xl').toInt().sp ?? double.nan,
      xl4 = gc?.getValue<String>('4xl').toInt().sp ?? double.nan,
      small = gc?.getValue<String>('small').toInt().sp ?? double.nan,
      large = gc?.getValue<String>('large').toInt().sp ?? double.nan,
      medium = gc?.getValue<String>('medium').toInt().sp ?? double.nan,
      normal = gc?.getValue<String>('normal').toInt().sp ?? double.nan,
      textFieldRadius = ((gc?.getValue<String>('xl').toInt() ?? 0) / 2).r,
      themedButtonRadius = ((gc?.getValue<String>('large').toInt() ?? 0) / 2).r,
      aboutPicRadius = (((gc?.getValue<String>('xl').toInt() ?? 0) + (gc?.getValue<String>('large').toInt() ?? 0)) / 2)
          .r,
      aboutAndInterestBorderRadius =
          gc?.getValue<String>('medium').toInt().r ?? double.nan,
      profileLetterSpacing = gc?.getValue<String>('profile_letter_spacing').toInt().sp ??
          double.nan,
      themedButtonWidth =
          gc?.getValue<String>('themed_button_width').toInt().w ?? double.nan,
      appleFieldWithoutBorderPadding =
          ((gc?.getValue<String>('medium').toInt() ?? 0) / 2).sp,
      themedButtonHeight = ((gc?.getValue<String>('4xl').toInt() ?? 0) * (gc?.getValue<String>('4xs').toInt() ?? 0))
          .h,
      saveAndCloseLineHeight =
          ((gc?.getValue<String>('save_and_close_line_height').toDouble() ?? double.nan) /
                  (gc?.getValue<String>('normal').toInt() ?? 1))
              .h,
      defaultGradientIconSize = (((gc?.getValue<String>('4xl').toInt() ?? 0) +
                  (gc?.getValue<String>('3xl').toInt() ?? 0) +
                  (gc?.getValue<String>('3xs').toInt() ?? 0)) /
              2)
          .sp,
      themedButtonLabelLineHeight =
          ((gc?.getValue<String>('themed_button_line_height').toDouble() ?? double.nan) / (gc?.getValue<String>('large').toInt() ?? 1)).h,
      bottomTextLineHeight = ((gc?.getValue<String>('bottom_text_line_height').toDouble() ?? double.nan) / (((gc?.getValue<String>('medium').toInt() ?? 1) + (gc?.getValue<String>('normal').toInt() ?? 1)) / 2)).h,
      authHeadingLineHeight = ((gc?.getValue<String>('auth_heading_line_height').toDouble() ?? double.nan) / (gc?.getValue<String>('4xl').toInt() ?? 1)).h,
      interestAndAboutLineHeight = ((gc?.getValue<String>('interest_and_about_line_height').toDouble() ?? double.nan) / (gc?.getValue<String>('medium').toInt() ?? 1)).h;
}
