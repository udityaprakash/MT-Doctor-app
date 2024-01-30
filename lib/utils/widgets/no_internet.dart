

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/loader.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';

class No_Internet extends StatelessWidget {
  const No_Internet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('No Internet')),
    );
  }
}

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // loading(),
            Center(
              child: Container(
                // padding: EdgeInsets.all(20),
                child: Lottie.asset(
                'assets/lottie/person.json',
                          ),
              ),
            ),
            // Image.asset('assets/images/error.png',
            //     fit: BoxFit.cover, height: double.infinity),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textasitis("Please check your Internet",22.0,'Lato', 500, ui.primaryclr,
                                      ),
                  textasitis("Connection",22.0,'Lato', 500, ui.primaryclr,
                                      ),                    
                  // Text('No Internet', context),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
