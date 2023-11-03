import 'dart:ui';

import 'package:flutter/material.dart';

Widget text(String title, Color color, double fontSize, FontWeight fontWeight ,{align}) {
    return Text(title,
    textAlign: align,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Lato',
          // fontStyle: fontStyle,
        ));
  }
 
 Widget textgenerator(
    String tex, double fontSiz, String fontfamly, double weit, Color co) {
  return Text(
    tex,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontFamily: fontfamly,
      fontSize: fontSiz,
      color: co,
      fontVariations: <FontVariation>[FontVariation('wght', weit)],
    ),
  );
}
