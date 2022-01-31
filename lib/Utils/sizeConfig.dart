import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenHeight;
  static late double screenWidth;
  static late double horizontalBlockSize;
  static late double verticalBlockSize;

  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    horizontalBlockSize = screenWidth / 100;
    verticalBlockSize = screenHeight / 100;
  }
}