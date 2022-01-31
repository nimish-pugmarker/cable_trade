import 'dart:math';

import 'package:flutter/material.dart';

class MyColors {
  static late MaterialColor colorCustomTheme, colorCustomTab;
  static late Color textColor, disabledTextColor, myBlue;
  Map<int, Color> themeColor = {
    50: const Color.fromRGBO(93, 163, 34, .1),
    100: const Color.fromRGBO(93, 163, 34, .2),
    200: const Color.fromRGBO(93, 163, 34, .3),
    300: const Color.fromRGBO(93, 163, 34, .4),
    400: const Color.fromRGBO(93, 163, 34, .5),
    500: const Color.fromRGBO(93, 163, 34, .6),
    600: const Color.fromRGBO(93, 163, 34, .7),
    700: const Color.fromRGBO(93, 163, 34, .8),
    800: const Color.fromRGBO(93, 163, 34, .9),
    900: const Color.fromRGBO(93, 163, 34, 11),
  };

  static List<Color> colorsArray = [colorCustomTheme, Colors.pink, Colors.orange, Colors.redAccent,Colors.deepPurple,
    Colors.blue, Colors.teal, Colors.purple];

  void init(BuildContext context){
    colorCustomTheme = MaterialColor(0xFF5DA322, themeColor);
    textColor = const Color.fromARGB(255, 110, 110, 110);
    myBlue = const Color.fromARGB(255, 0, 47, 126);
    disabledTextColor = const Color.fromARGB(255, 140, 140, 140);
  }
  Color getRandomColor(){
    final _random = Random();
    return colorsArray[_random.nextInt(colorsArray.length)];
  }


}