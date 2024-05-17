import 'package:flutter/material.dart';
import 'package:you_app/extensions/extensions.dart';

import '../../../utils/values.dart';
import 'custom_button.dart';

class MyButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  const MyButton({super.key, this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        onPressed: onPressed,
        type: 'border'.buttonType,
        style: css.themedButtonStyle,
        child: Ink(
            decoration: css.themedButtonDecoration,
            child: Center(
                child: label?.textWidget(style: css.themedButtonLabelStyle))));
  }
}
