import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/data/dataflow/devicestorage.dart';
import 'package:meditransparency/data/dataflow/integration_apis.dart';
import 'package:meditransparency/utils/widgets/button.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
import 'package:http/http.dart' as http;
import 'package:meditransparency/utils/widgets/toastmsg.dart';
import '../../widgets/reusable_text.dart';

class patientlist extends StatefulWidget {
  const patientlist({super.key});

  @override
  State<patientlist> createState() => _patientlistState();
}

class _patientlistState extends State<patientlist> {
  var selectedindex;
  List<String> patients = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 30),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: ui.primaryclr,
                            size: 45,
                          ),
                        ),
                        textgenerator(
                            'My Patients', 40, 'Lato', 300, ui.blackclr),
                        SizedBox(
                          height: 30,
                          width: 30,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: textgenerator('Select the patient you want to treat',
                        15, 'Lato', 300, ui.greyclr),
                  ),
                  Divider(
                    color: ui.primarymlightclr,
                    thickness: 1.5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: patientsinfo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data;
                          log("data passed is : " + data.toString());
                          if (snapshot.data["success"] == true) {
                            if (snapshot.data["count"] != 0) {
                              return ListView.builder(
                                itemCount: data["patientsinfo"]!.length,
                                itemBuilder: (context, index) {
                                  patients.add(
                                      data["patientsinfo"][index]["patientid"]);
                                  return InkWell(
                                    onTap: () {
                                      selectedindex = index;
                                      setState(() {});
                                    },
                                    child: Container(
                                      // color: Colors.red,
                                      margin: EdgeInsets.all(10),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: const Color.fromARGB(255, 219, 27, 27),
                                        border: (selectedindex == index)
                                            ? Border.all(
                                                color: ui.primaryclr, width: 2)
                                            : Border.all(color: ui.greyclr),
                                      ),
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // CachedNetworkImage(imageUrl: imageUrl),
                                            CircleAvatar(
                                              radius: 31,
                                              backgroundColor: ui.greyclr,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                  data["patientsinfo"][index]
                                                      ["imgurl"],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    textgenerator(
                                                        (data["patientsinfo"]
                                                                [index]["name"])
                                                            .toUpperCase(),
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                    textgenerator(
                                                        " | ",
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                    textgenerator(
                                                        (data["patientsinfo"]
                                                                [index]["age"]
                                                            .toString()),
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                    textgenerator(
                                                        " ",
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                    textgenerator(
                                                        (data["patientsinfo"]
                                                            [index]["gender"]),
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    textgenerator(
                                                        "Registered on  ",
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                    textgenerator(
                                                        (data["patientsinfo"]
                                                                [index]
                                                            ["registeredon"]),
                                                        15,
                                                        'Lato',
                                                        300,
                                                        ui.blackclr),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 5,
                                            )
                                          ]),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Center(
                                  child: textgenerator(
                                      'No patients for current hospital',
                                      15,
                                      'Lato',
                                      300,
                                      ui.primarylightclr));
                            }
                          } else {
                            return Center(
                                child: textgenerator(
                                    'Some Internal Error Occured',
                                    15,
                                    'Lato',
                                    300,
                                    ui.primarylightclr));
                          }
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              ),
                              Container(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator()),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ]),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,
          padding: EdgeInsets.all(10),
          child: buttongenerator('Continue', context, () async {
            if (selectedindex == null) {
              log('something is missing');
              if(patients.length!=0){

              Toastmsg(msg: 'Please select a patient');
              }else{
              Toastmsg(msg: "Try changing your current Hospital");

              }
            } else {
              print(patients[selectedindex]);
              StorageManager.saveData(
                  'selected_patient', patients[selectedindex]);
              StorageManager.readData('selected_patient').then((value) {
                print("selected patient is :" + value);
                // Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/homepage');
              });
            }
          }),
        ),
      ),
      // ),
    );
    ;
  }
}
