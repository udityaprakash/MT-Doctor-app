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

class Patient {
  final String imgUrl;
  final String name;
  final String patientId;
  final String gender;
  final int age;
  final String registeredOn;

  Patient(
      {required this.imgUrl,
      required this.name,
      required this.patientId,
      required this.gender,
      required this.age,
      required this.registeredOn});
}

class PatientService {
  // static const String token = 'YOUR_TOKEN_HERE';
  static const String url =
      'https://meditransparency.onrender.com/doctor/patients';
  // String? token = 
  //   log("doctor token is :" + token);
  //   log("selected hospital is: " + selhospital);    

  static Future<List<Patient>> getPatients() async {
    String? token = (await StorageManager.readData('token')).toString();
    String? hospitalId = (await StorageManager.readData('current_hospital_id')).toString();
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'},
      body: jsonEncode(<String, String>{'hospitalid': hospitalId}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success'] == true) {
        List<Patient> patients = [];
        for (var patientData in data['patientsinfo']) {
          patients.add(Patient(
            imgUrl: patientData['imgurl'],
            name: patientData['name'],
            patientId: patientData['patientid'],
            gender: patientData['gender'],
            age: patientData['age'],
            registeredOn: patientData['registeredon'],
          ));
        }
        return patients;
      } else {
        throw Exception('Failed to load patients');
      }
    } else {
      throw Exception('Failed to load patients');
    }
  }
}

class ApiService {
  static Future<List<Patient>> getPatientsDetail() async {
    String? token = (await StorageManager.readData('token')).toString();
    log("doctor token is :" + token);
    String? selhospital =
        (await StorageManager.readData('current_hospital_id')).toString();
    log("selected hospital is: " + selhospital);
    var response = await http.post(
        Uri.parse('https://meditransparency.onrender.com/doctor/patients'),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: "Bearer $token"
          // 'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"hospitalid": selhospital}));
    var data = jsonDecode(response.body);
    log("here:"+ data.toString());
    if (response.statusCode == 200) {
      List<Patient> patients = (data['patientsinfo'] as List)
          .map((item) => Patient.fromJson(item))
          .toList();
      return patients;
    } else {
      throw Exception('Failed to load patients');
    }
  }
}

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
                    child: textgenerator(
                        'My Patients', 40, 'Lato', 300, ui.blackclr),
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
                    child:FutureBuilder<List<Patient>>(
                      future: ApiService.getPatientsDetail(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Patient>? data = snapshot.data;
                          if (snapshot.data!.isNotEmpty) {
                            return ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                patients.add(data[index].patientid);
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
                                        children: [
                                          // CachedNetworkImage(imageUrl: imageUrl),
                                          CircleAvatar(
                                            radius: 31,
                                            backgroundColor: ui.greyclr,
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                data[index].imgUrl,
                                              ),
                                            ),
                                          ),
                                          textgenerator(
                                              (data[index].name).toUpperCase(),
                                              15,
                                              'Lato',
                                              300,
                                              ui.blackclr),
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
                                child: textgenerator('No hospitals to list', 15,
                                    'Lato', 300, ui.primarylightclr));
                          }
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        } else {
                          return CircularProgressIndicator();
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
            } else {
              print(patients[selectedindex]);
              StorageManager.saveData(
                  'selected_patient', patients[selectedindex]);
              StorageManager.readData('selected_patient').then((value){
                print("selected patient is :"+value);
                Navigator.pushReplacementNamed(context, '/choosepatient');
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
