import 'package:flutter/material.dart';
import 'package:meditransparency/data/dataflow/integration_apis.dart';
import 'package:meditransparency/utils/screens/homescreen/homescreen.dart';
import 'package:meditransparency/utils/screens/intro_screen.dart';
import 'package:meditransparency/data/constants/colors.dart';
import 'package:meditransparency/utils/widgets/loader.dart';

import '../homescreens/listofhospitals.dart';

class home_page_redirector extends StatefulWidget {
  const home_page_redirector({super.key});

  @override
  State<home_page_redirector> createState() => _home_page_redirectorState();
}

class _home_page_redirectorState extends State<home_page_redirector> {
  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder(
      future: issaveddata(),
      builder: (BuildContext context, AsyncSnapshot id_storage) {
        if (id_storage.data == null) {
          return Homepage();
        } else if (id_storage.hasData) {
          return listhospitals();
        } else {
          return Scaffold(
            body: Center(child:loading()),
          );
        }
      },
    );
  }
}
