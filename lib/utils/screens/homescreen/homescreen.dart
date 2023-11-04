import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditransparency/data/constants/colors.dart';

import '../../../data/dataflow/devicestorage.dart';
import '../../../data/dataflow/integration_apis.dart';
import '../../widgets/card generator/homepagecards.dart';
import '../../widgets/reusable_text.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    var tabs = [
      {
        "name": "Patients Details",
        "prefixicon": 'assets/svgs/patient.svg',
        "suffixsvg": "assets/svgs/patientsuffix.svg"
      },
      {
        "name": "Laboratory",
        "prefixicon": 'assets/svgs/laboratory.svg',
        "suffixsvg": "assets/svgs/laboratorysuffix.svg"
      },
      {
        "name": "Medicines",
        "prefixicon": 'assets/svgs/medicine.svg',
        "suffixsvg": "assets/svgs/medicinesuffix.svg"
      },
      {
        "name": "Live Monitor",
        "prefixicon": 'assets/svgs/livemonitor.svg',
        "suffixsvg": "assets/svgs/medicinesuffix.svg"
      }
    ];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ui.primaryclr, size: 30),
        backgroundColor: ui.backgroundclr,
        centerTitle: true,
        actions: [
          Row(
            children: [
              Text(
                'Gopinath',
                style: TextStyle(
                    color: ui.blackclr, fontFamily: 'Play', fontSize: 20),
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: ui.greyclr,
            ),
            iconSize: 30,
            onPressed: () async {
              try {
                log(" logging out");

                final token = await StorageManager.readData('selected_patient');
                log(" logging out user with value : " + token);
                // Navigator.of(context).pop();
                // Navigator.pushReplacementNamed(context, '/featurescreen');
              } catch (e) {
                log('error in logging out:' + e.toString());
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: ui.primaryclr,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              textgenerator('Welcome Back!', 30, 'Lato', 300, ui.blackclr),
              SizedBox(
                height: 10,
              ),
              textasitis(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
                  15,
                  'Lato',
                  300,
                  ui.greyclr),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  textgenerator('Patient Name: ', 20, 'Lato', 300, ui.blackclr),
                  SizedBox(
                    width: 5,
                  ),
                  FutureBuilder(
                    future: patientinfofromstorage(),
                    builder: (context, snapshot) {
                      log(snapshot.toString());
                      if (snapshot.hasData) {
                        return textgenerator(
                            '${(snapshot.data['name']).toString().toUpperCase()}',
                            20,
                            'Lato',
                            300,
                            ui.blackclr);
                        // Display the data if available
                      } else if (snapshot.hasError) {
                        return textgenerator('Unknown', 20, 'Lato', 300,
                            ui.blackclr); // Display an error message if an error occurs
                      }
                      return CircularProgressIndicator();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              slipecards(
                        prefix: tabs[0]['prefixicon'],
                        name: tabs[0]['name'],
                        suffix: tabs[0]['suffixsvg']),
                        SizedBox(
                height: 30,
              ),
              slipecards(
                        prefix: tabs[1]['prefixicon'],
                        name: tabs[1]['name'],
                        suffix: tabs[1]['suffixsvg']),
                        SizedBox(
                height: 30,
              ),
              slipecards(
                        prefix: tabs[2]['prefixicon'],
                        name: tabs[2]['name'],
                        suffix: tabs[2]['suffixsvg']),
                        SizedBox(
                height: 30,
              ),
              slipecards(
                        prefix: tabs[3]['prefixicon'],
                        name: tabs[3]['name'],
                        suffix: tabs[1]['suffixsvg'])                              
              // ListView.builder(
              //     itemCount:4,
              //     itemBuilder: (context, index) {
              //       return slipecards(
              //           prefix: tabs[index]['prefixicon'],
              //           name: tabs[index]['name'],
              //           suffix: tabs[index]['suffixsvg']);
              //     }),

              // Container(
              //     height: 100,
              //     decoration: BoxDecoration(
              //         // color: Colors.black38,
              //         gradient: LinearGradient(
              //           colors: [
              //             ui.primarylightclr,
              //             ui.primarymlightclr
              //           ], // Add your gradient colors here
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //           // stops: [0.0, 1.0],
              //           tileMode: TileMode.clamp,
              //         ),
              //         borderRadius: BorderRadius.circular(5)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 SvgPicture.asset(
              //                   "${tabs[1]['prefixicon']}",
              //                   height: 40,
              //                 ),
              //                 SizedBox(
              //                   width: 10,
              //                 ),
              //                 textgenerator('${tabs[1]['name']}', 20, 'Lato',
              //                     300, ui.blackclr)
              //               ],
              //             ),
              //           ],
              //         ),
              //         SizedBox(
              //           width: 10,
              //         ),
              //         SvgPicture.asset(
              //           "${tabs[1]['suffixsvg']}",
              //           height: 80,
              //         ),
              //       ],
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
