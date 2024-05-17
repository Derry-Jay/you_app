import 'package:flutter/material.dart';

import '../../../extensions/extensions.dart';
import '../../../utils/values.dart';

class BottomTextWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String? text1, text2;
  const BottomTextWidget({super.key, this.text1, this.text2, this.onTap});

  @override
  Widget build(BuildContext context) {
    final rec = tgr..onTap = onTap;
    return Center(
        child: TextSpan(text: text1, style: css.bottomTextStyle1, children: [
      TextSpan(text: text2, style: css.bottomTextStyle2, recognizer: rec)
    ]).wealthyText());
  }
}
