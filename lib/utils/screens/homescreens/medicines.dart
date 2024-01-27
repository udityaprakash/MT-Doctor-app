import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
class medicines extends StatefulWidget {
  const medicines({super.key});

  @override
  State<medicines> createState() => _medicinesState();
}

class _medicinesState extends State<medicines> {
  @override
  String displayText = '';
  bool showProgress = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showProgress = false;
        displayText = 'No Cameras were Detected';
      });
    });
  }
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
        title: textgenerator('Medicines', 27, 'Lato', 300, ui.blackclr),
        actions: [
          Row(
            children: [],
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showProgress
                ? CircularProgressIndicator(
                    color: ui.primaryclr,
                  )
                :
            textgenerator('No Past Medicines Found', 20, 'Lato', 300, ui.greyclr),
          ],
        ),
      ) 
    );
  }
}