import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';

Widget bottomdrawer({child, context}) {
  final size = MediaQuery.of(context).size;
  return Container(
    child: child,
    padding: EdgeInsets.all(25),
    width: size.width,
    height: size.height * 0.45,
    decoration:BoxDecoration(
    color: ui.backgroundclr,
    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
  ),
  );
}
