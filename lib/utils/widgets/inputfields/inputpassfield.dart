import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';

Widget Inputpassfield(String hinttxt, bool _passwordVisible, context, funct,
    {controller}) {
  return TextFormField(
    // initialValue: 'Input text',
    controller: controller,
    obscuringCharacter: '*',
    style: TextStyle(color: ui.blackclr, ),
    cursorColor: ui.primaryclr ,
    decoration: InputDecoration(
      isDense: true,
      focusColor: ui.primaryclr,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width:2, color: ui.primaryclr),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: ui.primaryclr),
      ),
      suffixIcon: IconButton(
        icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
            color: ui.greyclr
            ),
        onPressed: funct,
      ),
    ),
    obscureText: _passwordVisible,// Set this to true to hide the entered password
  );

  //  TextField(
  //   maxLines: 1,
  //   autofocus: false,
  //   cursorHeight: 25,
  //   // cursorColor: redclr,
  //   controller: controller,
  //   style: TextStyle(
  //     color: ui.blackclr,
  //     fontSize: 20,
  //     fontFamily: 'Lato',
  //     fontWeight: FontWeight.w300,
  //   ),
  //   obscureText: _passwordVisible,
  //   cursorOpacityAnimates: true,
  //   decoration: InputDecoration(
  //     isDense: true,
  //     focusColor: ui.primaryclr,
  //     focusedBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: ui.blackclr, width: 3),
  //     ),
  //     enabledBorder: UnderlineInputBorder(
  //       borderSide: BorderSide(color: ui.primaryclr),
  //     ),
  //     suffixIcon: IconButton(
  //       icon: Icon(_passwordVisible ? Icons.visibility_off : Icons.visibility,
  //           color: ui.greyclr
  //           // Theme.of(context).primaryColorDark,
  //           ),
  //       onPressed: funct,
  //     ),
  //     hintText: hinttxt,
  //     hintStyle: TextStyle(
  //         color: ui.greyclr,
  //         fontSize: 20,
  //         fontFamily: 'Lato',
  //         fontWeight: FontWeight.w300),
  //     filled: true,
  //   ),
  // ),
}
