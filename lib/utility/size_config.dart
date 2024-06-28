

import 'package:flutter/cupertino.dart';

class SizeConfig{

  static double? screenWidth;
  static double? screenHeight;
  static Orientation? screenOrientation;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.sizeOf(context).width;
    screenHeight = MediaQuery.sizeOf(context).height;
    screenOrientation = Orientation.portrait;
  }
}