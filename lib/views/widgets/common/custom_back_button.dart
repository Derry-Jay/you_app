import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../utils/values.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Row(children: [
          Flexible(
              child: Icons.arrow_back_ios.iconBuilder(color: shades.kWhite)),
          Flexible(
              flex: 7,
              child: 'Back'
                  .textWidget(style: css.backStyle, textAlign: TextAlign.left)),
        ]));
  }
}
