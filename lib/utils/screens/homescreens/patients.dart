import 'package:cached_network_image/cached_network_image.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'dart:developer';
import 'package:meditransparency/data/constants/colors.dart';

import 'package:flutter/material.dart';
import 'package:meditransparency/data/dataflow/integration_apis.dart';
import 'package:meditransparency/utils/widgets/loader.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';

// int calculateAge(String dobString) {
//   DateTime dob = DateTime.parse(dobString);
//   DateTime now = DateTime.now();

//   int age = now.year - dob.year;

//   // Check if the birthday has occurred this year
//   if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
//     age--;
//   }

//   return age;
// }

class patient extends StatefulWidget {
  const patient({super.key});

  @override
  State<patient> createState() => _patientState();
}

class _patientState extends State<patient> {
  final Future<dynamic> patientInfo = patientdetails();
  final Future<dynamic> medicalrecord = medicalrecords();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: patientInfo,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // log(snapshot.data['details'].toString());
              if (snapshot.data['success'] == true) {
                return Container(
                  width: size.width,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onLongPress: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const editprofile()),
                          // );
                        
                        },
                        child: CircleAvatar(
                          radius: 62,
                          backgroundColor: ui.greyclr,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: CachedNetworkImageProvider(
                              snapshot.data["imgurl"],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                textgenerator(
                                    'Name', 20, 'Lato', 300, ui.greyclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    'Patient ID', 20, 'Lato', 300, ui.greyclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    'Age', 20, 'Lato', 300, ui.greyclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    'Weight', 20, 'Lato', 300, ui.greyclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    'Blood Grp', 20, 'Lato', 300, ui.greyclr),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                textgenerator(
                                    '${(snapshot.data['details']['patient_name']).toString().toUpperCase()}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    '${(snapshot.data['details']['_id']).toString().toUpperCase().substring(16)}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    '${calculateage((snapshot.data['details']['general_details']['dob']).toString())}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    '${(snapshot.data['details']['general_details']['weight']).toString()}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    '${(snapshot.data['details']['general_details']['bloodGroup']).toString()}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          textgenerator(
                              // 'hello',
                              'Contact Details',
                              30,
                              'Lato',
                              300,
                              ui.blackclr),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                textgenerator(
                                    'Ph no', 20, 'Lato', 300, ui.greyclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    'Email', 20, 'Lato', 300, ui.greyclr),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textgenerator(
                                    '${(snapshot.data['details']['phone_number']).toString()}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                                SizedBox(
                                  height: 10,
                                ),
                                textgenerator(
                                    '${(snapshot.data['details']['email']).toString()=='null' ? '--' : (snapshot.data['details']['email']).toString()}',
                                    20,
                                    'Lato',
                                    300,
                                    ui.blackclr),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          textgenerator(
                              // 'hello',
                              'Medical History',
                              30,
                              'Lato',
                              300,
                              ui.blackclr),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: medicalrecord,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              log(snapshot.data.toString());
                              if(snapshot.data['success'] == true ){
                                if(snapshot.data['count'] == 0){
                      
                                  return Container(
                                    height: 100,
                                    child: Center(
                                      child: textgenerator(
                                          'No medical records found',
                                          20,
                                          'Lato',
                                          300,
                                          ui.primarylightclr),
                                    ),
                                  );
                                }else{
                                  return Container(
                                    height:200,
                                    width: size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data['count'],
                                      itemBuilder: (context, index) {
                                      return buildItem(snapshot.data['data'][index]);
                                    },
                                      // child: textgenerator(
                                      //     'No medical records found',
                                      //     20,
                                      //     'Lato',
                                      //     300,
                                      //     ui.blackclr),
                                    ),
                                  );
                                }
                      
                              }else{
                                return textgenerator(
                                  'Some Error Occured',
                                  20,
                                  'Lato',
                                  300,
                                  ui.blackclr);
                      
                              }
                            } else if (snapshot.hasError) {
                              return textgenerator(
                                  'Failed To Load, Please retry',
                                  20,
                                  'Lato',
                                  300,
                                  ui.blackclr); // Display an error message if an error occurs
                            } else {
                              return Container(
                                  width: size.width,
                                  height: size.height * 0.2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loading(),
                                    ],
                                  ));
                            }
                          })
                    ],
                  ),
                );
              } else {
                return textgenerator(
                    '${snapshot.data['msg']}', 20, 'Lato', 300, ui.blackclr);
              }
              // Display the data if available
            } else if (snapshot.hasError) {
              return textgenerator(
                  'Failed To Load, Please retry',
                  20,
                  'Lato',
                  300,
                  ui.blackclr); // Display an error message if an error occurs
            } else {
              return Container(
                  width: size.width,
                  height: size.height * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      loading(),
                    ],
                  ));
            }
          },
        ),
      )),
    );
  }
}

int? calculateage(String dobString) {
  DateTime dob = DateTime.parse(dobString);
  DateTime now = DateTime.now();

  int age = now.year - dob.year;

  // Check if the birthday has occurred this year
  if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
    age--;
  }

  return age;
}


Widget buildItem(Map data) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
           
      decoration: BoxDecoration(
        // color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: ui.greyclr,
          width: 2.0, // Set the border width
          )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(imageUrl: (data['imgurl']).toString(),
              fit: BoxFit.cover, // Set the fit property to cover
              width: 150, // Set the width of the container
              height: 150,
                placeholder: (context, url) => Container(height:100,width:100, child: loading()),
                errorWidget: (context, url, error) => Icon(Icons.error),),
            ),
          ),
          textgenerator(
            // ''
                    '${data['title']}'
                    , 15, 'Lato', 300, ui.blackclr)
        ],
      ),
    );
  }

  class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}