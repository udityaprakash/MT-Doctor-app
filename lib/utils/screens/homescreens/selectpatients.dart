import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/data/dataflow/devicestorage.dart';
import 'package:meditransparency/utils/widgets/button.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
import 'package:http/http.dart' as http;
import '../../widgets/reusable_text.dart';

class patientlist extends StatefulWidget {
  const patientlist({super.key});

  @override
  State<patientlist> createState() => _patientlistState();
}

class _patientlistState extends State<patientlist> {
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
                    child:
                        textgenerator('My Patients', 40, 'Lato', 300, ui.blackclr),
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
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      log("start");
                    },
                    child: textgenerator('No patients have been added', 15 , 'Lato', 300, ui.primarylightclr)
                    // FutureBuilder<List<Hospital>>(
                    //   future: ApiService.getHospitalDetails(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       List<Hospital>? data = snapshot.data;
                    //       return ListView.builder(
                    //         itemCount: data!.length,
                    //         itemBuilder: (context, index) {
                    //           hospitals.add(data[index].name);
                    //           return InkWell(
                    //             onTap: () {
                    //               selectedindex = index;
                    //               setState(() {});
                    //             },
                    //             child: Container(
                    //               // color: Colors.red,
                    //               margin: EdgeInsets.all(10),
                    //               height: 100,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 // color: const Color.fromARGB(255, 219, 27, 27),
                    //                 border: (selectedindex == index)
                    //                     ? Border.all(
                    //                         color: ui.primaryclr, width: 2)
                    //                     : Border.all(color: ui.greyclr),
                    //               ),
                    //               width: double.infinity,
                    //               padding: EdgeInsets.all(10),
                    //               child: Row(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.spaceAround,
                    //                   children: [
                    //                     // CachedNetworkImage(imageUrl: imageUrl),
                    //                     CircleAvatar(
                    //                       radius: 31,
                    //                       backgroundColor: ui.greyclr,
                    //                       child: CircleAvatar(
                    //                         radius: 30,
                    //                         backgroundImage:
                    //                             CachedNetworkImageProvider(
                    //                           data[index].imgUrl,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     textgenerator(
                    //                         (data[index].name).toUpperCase(),
                    //                         15,
                    //                         'Lato',
                    //                         300,
                    //                         ui.blackclr),
                    //                     SizedBox(
                    //                       width: 5,
                    //                     )
                    //                   ]),
                    //             ),
                    //           );
                    //         },
                    //       );
                    //     } else if (snapshot.hasError) {
                    //       return Text("${snapshot.error}");
                    //     } else {
                    //       return CircularProgressIndicator();
                    //     }
                    //   },
                    // ),
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
            // if (selectedindex == null) {
            //   log('something is missing');
            // } else {
            //   print(hospitals[selectedindex]);
            //   StorageManager.saveData(
            //       'hospital_selected', hospitals[selectedindex]);
            //   StorageManager.readData('hospital_selected').then((value){
            //     print("stored token was :"+value);
            //     Navigator.pushReplacementNamed(context, '/choosepatient');
            //   });
            // }
          }),
        ),
      ),
      // ),
    );;
  }
}