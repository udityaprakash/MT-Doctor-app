import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:meditransparency/utils/screens/auth_screens/sign_in_screen.dart';
import 'package:meditransparency/utils/screens/homescreen/homepageredirector.dart';
import 'package:meditransparency/utils/screens/homescreen/homescreen.dart';
import 'package:meditransparency/utils/screens/homescreens/listofhospitals.dart';
import 'package:meditransparency/utils/screens/homescreens/selectpatients.dart';
import 'package:meditransparency/utils/screens/intro_screen.dart';
import 'package:meditransparency/utils/screens/splash_screen.dart';
import 'package:meditransparency/utils/screens/termsandpolicy/privacypolicy.dart';
import 'package:meditransparency/utils/screens/termsandpolicy/termsofuse.dart';
import 'package:meditransparency/utils/widgets/no_internet.dart';
import 'package:provider/provider.dart';

import 'data/dataflow/internetconnectivity.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) {
      final bool isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
      if (!isOnline) {
        return NoConnectionScreen();
      }
      switch (settings.name) {
        case "/splashpage":
          // ignore: prefer_const_constructors
          return SplashScreen();
        case "/":
          break;
        case "/featurescreen":
          return Homepage();
        case '/privacy_policy':
          return privacy_policy();
        case '/termsofuse':
          return Termsofuse();
        case "/login":
          return SignInScreen();
        case "/choosehospital":
          return listhospitals();
        case "/choosepatient":
          return patientlist();
        case "/homepage":
          return homepage();
        case "/homepageredirector":
          return home_page_redirector();
        case "signinscreen":
          return SignInScreen();
      }
      log("Settings name: "+(settings.name).toString());
      // ignore: prefer_const_constructors
      return Homepage();
    });
  }
}
