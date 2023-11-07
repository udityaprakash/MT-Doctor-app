import 'package:meditransparency/data/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';

class patient extends StatefulWidget {
  const patient({super.key});

  @override
  State<patient> createState() => _patientState();
}

class _patientState extends State<patient> {
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
        title: textgenerator('Patients Details', 27, 'Lato', 300, ui.blackclr),
        actions: [
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
