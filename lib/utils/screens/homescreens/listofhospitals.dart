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

class Hospital {
  final String imgUrl;
  final String name;
  final String hospitalid;

  Hospital({required this.imgUrl, required this.hospitalid, required this.name});

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      imgUrl: json['imgurl'],
      hospitalid: json['hospital_id'],
      name: json['name'],
    );
  }
}

class ApiService {
  static Future<List<Hospital>> getHospitalDetails() async {
    String? token = (await StorageManager.readData('token')).toString();
    log("hdde" + token);
    var response = await http.get(
      Uri.parse('https://meditransparency.onrender.com/doctor/hospitals'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: "Bearer $token"
        // 'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<Hospital> hospitals = (data['hospitaldetails'] as List)
          .map((item) => Hospital.fromJson(item))
          .toList();
      return hospitals;
    } else {
      throw Exception('Failed to load hospitals');
    }
  }
}

class listhospitals extends StatefulWidget {
  const listhospitals({super.key});

  @override
  State<listhospitals> createState() => _listhospitalsState();
}

class _listhospitalsState extends State<listhospitals> {
  var selectedindex;
  List<String> hospitals = [];
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
                        textgenerator('Hospital', 40, 'Lato', 300, ui.blackclr),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: textgenerator('Select the hospital you practise in',
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
                    child: FutureBuilder<List<Hospital>>(
                      future: ApiService.getHospitalDetails(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Hospital>? data = snapshot.data;
                          if(snapshot.data!.isNotEmpty){
                            return ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                hospitals.add(data[index].hospitalid);
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

                          }else{
                            return Center(child: textgenerator('No hospitals to list', 15 , 'Lato', 300, ui.primarylightclr));
                          }
                        } else if (snapshot.hasError) {
                          return textgenerator('${snapshot.error}', 15 , 'Lato', 300, ui.primarylightclr);
                        } else {
                          return Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
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
            } else {
              print(hospitals[selectedindex]);
              StorageManager.saveData(
                  'current_hospital_id', hospitals[selectedindex]);
              StorageManager.readData('current_hospital_id').then((value){
                print("stored hospital id was :"+value);
                Navigator.pushReplacementNamed(context, '/choosepatient');
              });
            }
          }),
        ),
      ),
      // ),
    );
  }
}
