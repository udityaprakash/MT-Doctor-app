import 'package:meditransparency/data/constants/colors.dart';

import 'package:flutter/material.dart';

Widget Inputnumfield(String hinttxt, context, funct,
    {Placeholder,controller,autofocus}) {
  return TextFormField(
    // initialValue: 'Input text',
    controller: controller,
    autofocus: autofocus,
    keyboardType: TextInputType.phone,
    style: TextStyle(
      color: ui.blackclr,
    ),
    cursorColor: ui.primaryclr,
    decoration: InputDecoration(
      isDense: true,
      focusColor: ui.errclr,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width:2, color: ui.primaryclr),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ui.primaryclr),
      ),
    ),
  );
}
