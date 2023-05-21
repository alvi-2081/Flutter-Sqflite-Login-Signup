import 'package:flutter/material.dart';

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}

class AppColors {
  /* <----------- Colors ------------> */
  static const Color green = Color(0xff0EBE7E);
  static const Color greenLight = Color(0xffE4FCF3);
  static const Color grey = Color(0xff7881A0);
  static const Color greyText = Color(0xffA2A0A8);
  static const Color greyBorder = Color(0xffE5E8ED);
  static const Color greyBorderDark = Color(0xff87898d);
  static const Color error = Colors.redAccent;

  static Color borderColor(context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.greyBorderDark
        : AppColors.greyBorder;
  }

  static Color backgroundColor(context) =>
      Theme.of(context).scaffoldBackgroundColor;
}
