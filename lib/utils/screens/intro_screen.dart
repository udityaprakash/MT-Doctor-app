import 'dart:math';
import 'dart:developer'; 
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/button.dart';


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SvgPicture.asset(
                        'assets/svgs/top_notch.svg',
                        width: MediaQuery.of(context).size.width,
        ),
        // Image.asset(
        //   'assets/svgs/top_notch.png',
        //   height: MediaQuery.of(context).size.height * 0.3,
        // ),
        SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 35,
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      // textgenerator('', 0, "Poppins", 100, Colors.black),
                      SvgPicture.asset(
                        'assets/svgs/aplogo.svg',
                        width: MediaQuery.of(context).size.width,
                      ),
                      // Image.asset('assets/images/meditransparencyicon.png'),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: buttongenerator('Login', context, () {
                                Navigator.pushNamed(context, '/login');
                              }),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                // style: defaultStyle,
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "By continuing you Agree to MEDITRANSPARENCY's",
                                      style: TextStyle(
                                          color: ui.blackclr,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25)),
                                  TextSpan(
                                      text: ' Terms of Use',
                                      style: TextStyle(
                                          color:ui.primaryclr,
                                          decoration: TextDecoration.underline,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context, '/termsofuse');
                                          print('Terms of Use');
                                        }),
                                  TextSpan(
                                      text: ' Read our ',
                                      style: TextStyle(
                                          color: ui.blackclr,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25)),
                                  TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                          color:ui.primaryclr,
                                          decoration: TextDecoration.underline,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(context, '/privacy_policy');
                                          print("privacy policy");
                                        }),
                                ],
                              ),
                            ),
                            // textgenerator(
                            //     "By continuing you Agree to MEDITRANSPARENCY's Terms of Use. Read our privacy Policy",
                            //     MediaQuery.of(context).size.width / 30,
                            //     'Poppins',
                            //     800,
                            //     Color.fromARGB(255, 239,34,92)),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
