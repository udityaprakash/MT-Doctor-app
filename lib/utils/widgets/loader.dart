import 'package:meditransparency/data/constants/colors.dart';
import 'package:flutter/material.dart';

Widget loading() {
  return Center(
    child: CircularProgressIndicator(
      strokeWidth: 2,
      color: ui.primaryclr,
      backgroundColor: ui.loadingbackgroundclr,
    ),
  );
}