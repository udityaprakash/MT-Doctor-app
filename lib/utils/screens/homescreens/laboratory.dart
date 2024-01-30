import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meditransparency/data/dataflow/devicestorage.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
import 'package:meditransparency/data/constants/colors.dart';

class laboratory extends StatefulWidget {
  const laboratory({super.key});

  @override
  State<laboratory> createState() => _laboratoryState();
}

class _laboratoryState extends State<laboratory> {
  Future<Map?> lab() async {
  try {
    String? token = (await StorageManager.readData('token')).toString();
    // log("doctor token is :" + token);
    // String? selhospital =
    //     (await StorageManager.readData('current_hospital_id')).toString();
    // log("Initialised Profile get for: " + token);
    final response = await http.post(
      Uri.parse('https://meditransparency.onrender.com/doctor/profiledetails'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final Map output = jsonDecode(response.body);
    log("lab response " + output.toString());

    return output;
  } catch (er) {
    log("error in laboratory section " + er.toString());
  }
}
// var g = lab();
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
      body: Container(
        width: MediaQuery.of(context).size.width, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            showProgress
                ? loading()
                :
            textgenerator('No Lab Tests Found', 20, 'Lato', 300, ui.greyclr),
          ],
        ),
      ) 
    );
  }
}