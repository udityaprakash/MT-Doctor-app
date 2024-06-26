import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';

import '../../widgets/reusable_text.dart';

class privacy_policy extends StatelessWidget {
  const privacy_policy({super.key});
  final String terms='Subject to the terms of this License Agreement, Meditransparency hereby grants you a non-transferable, non-exclusive, revocable, non-sublicensable, royalty-free license to use, reproduce and display Meditransparency name, trademarks, service marks and logos identified as set out in the License Content Usage Guidelines (collectively, “Marks”), solely for purposes of performing your obligations or exercising your rights under this License Agreement and strictly in accordance with the License Content Usage Guidelines. Your data controller is responsible for the collection, use, disclosure, retention, and protection of your personal information in accordance with its privacy standards as well as any applicable national laws. Your data controller may transfer data to other members of Meditransparency as described in this Privacy Policy. Meditransparency may process and retain your personal information on its servers in India where its data centers are located, and/or on the servers of its third parties (in or outside India), having contractual relationships with Meditransparency.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ui.primaryclr,
        // centerTitle: true,
        title: Text(
          'Privacy Policy',
          style: TextStyle(
              fontFamily: 'Lato',
              fontSize: MediaQuery.of(context).size.width / 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          // height: MediaQuery.of(context).size.height*0.7,
          width: double.infinity,
          // color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left:20,top: 20),
                child: textasitis(terms, 15, 'Lato', 300, ui.greyclr),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}