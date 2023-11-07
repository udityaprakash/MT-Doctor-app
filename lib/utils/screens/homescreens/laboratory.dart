import 'package:flutter/material.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
import 'package:meditransparency/data/constants/colors.dart';

class laboratory extends StatefulWidget {
  const laboratory({super.key});

  @override
  State<laboratory> createState() => _laboratoryState();
}

class _laboratoryState extends State<laboratory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ui.primaryclr, size: 30),
        backgroundColor: ui.backgroundclr,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            color: ui.primaryclr,
            size: 45,
          ),
        ),
        title: textgenerator('Laboratory', 27, 'Lato', 300, ui.blackclr),
        actions: [
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}