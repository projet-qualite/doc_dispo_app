import 'dart:ui';

import 'package:flutter/material.dart';

Color colorWidget = Color.fromRGBO(59, 139, 150, 1);
Color colorNavigationItemUnselected = const Color.fromRGBO(101, 101, 101, 1);
Color colorRdv = const Color.fromRGBO(210, 210, 210, 1);
Color pageViewSelected = const Color.fromRGBO(0, 69, 79, 1);
Color pageViewUnselected = const Color.fromRGBO(164, 164, 164, 1);


Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(59, 139, 150, .2),
  200:Color.fromRGBO(59, 139, 150, .3),
  300:Color.fromRGBO(59, 139, 150, .4),
  400:Color.fromRGBO(59, 139, 150, .5),
  500:Color.fromRGBO(59, 139, 150, .6),
  600:Color.fromRGBO(59, 139, 150, .7),
  700:Color.fromRGBO(59, 139, 150, .8),
  800:Color.fromRGBO(59, 139, 150, .9),
  900:Color.fromRGBO(59, 139, 150, 1),
};


MaterialColor colorCustom = MaterialColor(0xFF3B8B96, color);
