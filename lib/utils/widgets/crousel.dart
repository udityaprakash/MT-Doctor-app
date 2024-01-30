import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:meditransparency/utils/widgets/reusable_text.dart';
import 'package:meditransparency/data/constants/colors.dart';
import '../screens/homescreen/homescreen.dart';

Widget buildCarousel(List<Offer> offers) {
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
  final random = Random();
  if (offers.length != 0) {
      return CarouselSlider.builder(
        itemCount: offers.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Image.network(
              offers[index].offerUrl,
              cacheHeight: 500,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              // Image is fully loaded
              return child;
            } else {
              // Image is still loading, show a loader
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ui.primaryclr,
                  backgroundColor: ui.loadingbackgroundclr,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
        ),
            // ),
            
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 16 / 6,
          viewportFraction: 0.8,
          autoPlayCurve: Curves.easeInOut,
          autoPlayAnimationDuration: Duration(seconds: 2),
        ),
      );

  }else{
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
  }
}
