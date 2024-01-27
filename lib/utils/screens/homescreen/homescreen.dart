import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:http/http.dart' as http;

import 'package:meditransparency/data/dataflow/devicestorage.dart';
import 'package:meditransparency/utils/widgets/toastmsg.dart';
import '../../../data/dataflow/integration_apis.dart';
import '../../widgets/card generator/homepagecards.dart';
import '../../widgets/crousel.dart';
import '';
import '../../widgets/reusable_text.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final List<String> doctorThoughts = [
    "Your dedication to healing makes a difference every day.",
    "Empathy is the greatest medicine.",
    "Your commitment to patient care is truly inspiring.",
    "Every small act of kindness in your practice creates a ripple effect.",
    "Keep learning, keep growing; medicine is an ever-evolving field.",
    "A smile and a kind word can be as healing as any medicine.",
    "Your compassion brings comfort to those who need it most.",
    "In the journey of healing, patience is a virtue.",
    "Your expertise makes you a true healer.",
    "Remember, self-care is as important as caring for others."
  ];

  var tabs = [
    {
      "name": "Patients Details",
      "prefixicon": 'assets/svgs/patient.svg',
      "suffixsvg": "assets/imagess/patient.png"
    },
    {
      "name": "Laboratory",
      "prefixicon": 'assets/svgs/laboratory.svg',
      "suffixsvg": "assets/imagess/laboratory.png"
    },
    {
      "name": "Medicines",
      "prefixicon": 'assets/svgs/medicine.svg',
      "suffixsvg": "assets/imagess/medicine.png"
    },
    {
      "name": "Live Monitor",
      "prefixicon": 'assets/svgs/livemonitor.svg',
      "suffixsvg": "assets/imagess/livemonitor.png"
    }
  ];

  String randomThought = "";

  final Future<dynamic> pInfo = patientinfofromstorage();
  final Future<dynamic> doctorInfo = doctordetails();
  late Future<List<Offer>> _offersFuture;

  // final Future<dynamic> doctor = doctorinfofromstorage();
  final List<String> menuOptions = [
    'Appointments',
    'Balance',
    'Notifications',
    'Help Center',
    'Feedback'
  ];
  int _selectedIndex = 0;

  Future<List<Offer>> fetchOffers() async {
    final String apiUrl =
        'https://meditransparency.onrender.com/admin/getoffers'; // Replace with your API URL
    // final String authToken = 'YOUR_TOKEN_HERE'; // Replace with your actual token
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        // 'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      Map<String, dynamic> data = json.decode(response.body);
      if (data['success'] == true && data['offers'] != null) {
        // Assuming the API response contains a 'success' key and an 'offers' list
        List<dynamic> offersData = data['offers'];
        // log(offersData.toString());
        return offersData.map((item) => Offer.fromJson(item)).toList();
      } else {
        throw Exception('API request unsuccessful');
      }
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load offers');
    }
  }

  @override
  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    _offersFuture = fetchOffers();
  }

  
  final random = Random();


  Widget build(BuildContext context) {
    // print('doctorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr - ' + doctor.toString());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ui.primaryclr, size: 30),
        backgroundColor: ui.backgroundclr,
        centerTitle: true,
        actions: [
          Row(
            children: [
              InkWell(
                onTap: (){

                },
                child: FutureBuilder(
                  future: doctorInfo,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          textgenerator(
                              '${((snapshot.data!['data']['name']).toString()).toUpperCase()}',
                              20,
                              'Lato',
                              300,
                              ui.blackclr),
                          const SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: ui.greyclr,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundImage: CachedNetworkImageProvider(
                                (snapshot.data!['data']['imgurl']),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      );
                      // Display the data if available
                    } else if (snapshot.hasError) {
                      return textgenerator('Unknown', 20, 'Lato', 300,
                          ui.blackclr); // Display an error message if an error occurs
                    }
                    return CircularProgressIndicator(color: ui.primaryclr,);
                  },
                ),
              )
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // SizedBox(height: size.height * 0.1,),
            Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              height: size.height,
              color: ui.primaryclr,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: ui.backgroundclr,
                          child: Image.asset(
                            "assets/imagess/logo.png",
                          ),
                        ),
                        textgenerator('MediTransparency', 25, 'Lato', 300,
                            ui.backgroundclr),
                      ],
                    ),
                  ),
                  Container(
                    // color: ui.blackclr,
                    height: size.height * 0.6,
                    child: ListView.builder(
                      itemCount: menuOptions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Toastmsg(
                                msg: "Options has been disabled by the Admin");
                            // Navigator.pop(context); // Close the drawer
                            _navigateTo(index);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? ui.backgroundclr
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: textgenerator(
                                menuOptions[index],
                                18,
                                'Lato',
                                300,
                                _selectedIndex == index
                                    ? ui.primaryclr
                                    : ui.backgroundclr),
                            // Text(
                            //   menuOptions[index],
                            //   style: TextStyle(
                            //     color: _selectedIndex == index ? Colors.blue : Colors.white,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ),
                        );
                      },
                    ),
                  ),
                  // textgenerator('Hospital', 25, 'Lato', 300, ui.backgroundclr),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 40),
                        alignment: Alignment.center,
                        width: 450,
                        height: 1,
                        color: ui.backgroundclr,
                      ),
                      textgenerator('app version 1.2.0', 17, 'Lato', 300,
                          ui.transbackgroundclr),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<List<Offer>>(
                future: fetchOffers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError ) {
                    return Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        textgenerator(
                            'Welcome Back!', 30, 'Lato', 300, ui.blackclr),
                        const SizedBox(
                          height: 10,
                        ),
                        textasitis(
                            doctorThoughts[random.nextInt(doctorThoughts.length)],
                            15,
                            'Lato',
                            300,
                            ui.greyclr),
                      ]),
                    );
                  }else {
                    return buildCarousel(snapshot.data!);
                  }
                },
              ),
              // textgenerator('Welcome Back!', 30, 'Lato', 300, ui.blackclr),
              // const SizedBox(
              //   height: 10,
              // ),
              // textasitis(doctorThoughts[random.nextInt(doctorThoughts.length)], 15, 'Lato', 300, ui.greyclr),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  textgenerator('Patient Name: ', 20, 'Lato', 300, ui.blackclr),
                  const SizedBox(width: 5),
                  FutureBuilder(
                    future: pInfo,
                    builder: (context, snapshot) {
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
                      } else {
                        return CircularProgressIndicator(color: ui.primaryclr,);
                      }
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pushNamed(context, '/patient');
              //   },
              //   child: Container(
              //     width: 200,
              //     height: 100,
              //     color: Colors.red,
              //   ),
              // ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/patient')},
                child: slipecards(
                    prefix: tabs[0]['prefixicon'],
                    name: tabs[0]['name'],
                    suffix: tabs[0]['suffixsvg']),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/lab')},
                child: slipecards(
                    prefix: tabs[1]['prefixicon'],
                    name: tabs[1]['name'],
                    suffix: tabs[1]['suffixsvg']),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/med')},
                child: slipecards(
                    prefix: tabs[2]['prefixicon'],
                    name: tabs[2]['name'],
                    suffix: tabs[2]['suffixsvg']),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/livem')},
                child: slipecards(
                    prefix: tabs[3]['prefixicon'],
                    name: tabs[3]['name'],
                    suffix: tabs[3]['suffixsvg']),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Offer {
  final String offerId;
  final String offerUrl;

  Offer({required this.offerId, required this.offerUrl});

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      offerId: json['offerid'].toString(),
      offerUrl: json['imageurl'],
    );
  }
}
