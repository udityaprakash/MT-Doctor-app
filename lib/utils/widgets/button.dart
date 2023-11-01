import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';

Widget btn({tex, function, style, context}) {
  final style = ElevatedButton.styleFrom(
      primary: ui.primaryclr,
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(2)
      );
  final size = MediaQuery.of(context).size;
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      width: size.width,
      child: ElevatedButton(
        style: style,
        onPressed: function,
        child: text(tex, ui.backgroundclr, 25.0, FontWeight.w500),
      ));

}

Widget nextorcontinuebtn({tex, function, style, context}) {
  final style = ElevatedButton.styleFrom(
      primary: ui.primaryclr,
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1400)),
      padding: EdgeInsets.all(7)
      );
  final size = MediaQuery.of(context).size;
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      // height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: style,
        onPressed: function,
        child: text(tex, ui.backgroundclr, 25.0, FontWeight.w500),
      ));

}

Widget buttongenerator(String quote, BuildContext context, function) {
  return ElevatedButton(
    onPressed: function,
    style: ElevatedButton.styleFrom(
      primary: ui.primaryclr,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        // side: const BorderSide(
        //     color: Colors.white),
      ),
    ),
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.007),
        child: Text(
          quote,
          style: TextStyle(
              letterSpacing: 1,
              color: Colors.white,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              // fontVariations: <FontVariation>[FontVariation('wght', 700)],
              fontSize: MediaQuery.of(context).size.width / 22),
        ),
      ),
    ),
  );
}