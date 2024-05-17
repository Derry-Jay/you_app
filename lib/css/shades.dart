import 'package:flutter/material.dart';

import '../models/common/shade.dart';

class Shades {
  static final Shades _singleton = Shades._internal();

  factory Shades() => _singleton;

  Shades._internal();

  final kGrey = Colors.grey,
      kTeal = Colors.teal,
      kBlue = Colors.blue,
      kBlack = Colors.black,
      kWhite = Colors.white,
      kLightBlue = Colors.lightBlue,
      kBlueAccent = Colors.blueAccent,
      kTransparent = Colors.transparent,
      kBlue1 = Shade(1, 'blue').fromConfigs,
      kCyan1 = Shade(1, 'cyan').fromConfigs,
      kGrey1 = Shade(1, 'grey').fromConfigs,
      kGrey2 = Shade(2, 'grey').fromConfigs,
      kGrey3 = Shade(3, 'grey').fromConfigs,
      kGold1 = Shade(1, 'gold').fromConfigs,
      kBlack1 = Shade(1, 'black').fromConfigs,
      kBlack2 = Shade(2, 'black').fromConfigs,
      kBlack3 = Shade(3, 'black').fromConfigs,
      kBlack4 = Shade(4, 'black').fromConfigs,
      kBrown1 = Shade(1, 'brown').fromConfigs,
      kBrown2 = Shade(2, 'brown').fromConfigs,
      kBrown3 = Shade(3, 'brown').fromConfigs,
      kBrown4 = Shade(4, 'brown').fromConfigs,
      kBrown5 = Shade(5, 'brown').fromConfigs,
      kWhite1 = Shade(1, 'white').fromConfigs,
      kWhite2 = Shade(2, 'white').fromConfigs,
      kWhite3 = Shade(3, 'white').fromConfigs,
      kWhite4 = Shade(4, 'white').fromConfigs,
      kWhite5 = Shade(5, 'white').fromConfigs,
      kWhite6 = Shade(6, 'white').fromConfigs;
}
