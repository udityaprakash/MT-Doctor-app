import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';

class listhospitals extends StatefulWidget {
  const listhospitals({super.key});

  @override
  State<listhospitals> createState() => _listhospitalsState();
}

class _listhospitalsState extends State<listhospitals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height- 100,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 30),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: textgenerator('Hospital', 40, 'Lato', 300, ui.blackclr),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: textgenerator('Select the hospital you practise in', 15, 'Lato', 300, ui.greyclr),
                  ),
                  Divider(
                    color: ui.primarymlightclr,
                    thickness: 1.5,
                  ),

              
                ]
              ),
            ),
            
            ),
          ),
      );
  }
}