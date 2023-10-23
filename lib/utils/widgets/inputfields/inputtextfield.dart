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
      color: Colors.black,
    ),
    decoration: InputDecoration(
      isDense: true,
      focusColor: ui.primaryclr,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ui.primaryclr),
      ),
      // suffixIcon: IconButton(
      //   icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
      //       color: ui.greyclr),
      //   onPressed: funct,
      // ),
    ), // Set this to true to hide the entered password
  );
}
