import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
import 'package:meditransparency/data/constants/colors.dart';

Widget slipecards({prefix, name, suffix}) {
  return Container(
      height: 100,
      decoration: BoxDecoration(
          // color: Colors.black38,
          gradient: LinearGradient(
            colors: [
              ui.primarylightclr,
              ui.primarymlightclr
            ], // Add your gradient colors here
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "${prefix.toString()}",
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  textgenerator(
                      '${name.toString()}', 20, 'Lato', 300, ui.blackclr)
                ],
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            "${suffix.toString()}",
            height: 80,
          ),
        ],
      ));
}
