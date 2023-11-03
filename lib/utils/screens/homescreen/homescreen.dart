import 'package:flutter/material.dart';
import 'package:meditransparency/data/constants/colors.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ui.primaryclr,
          centerTitle: true,
          title: Text(
            'Meditransparency',
            style: TextStyle(
                fontFamily: 'Play',
                fontSize: MediaQuery.of(context).size.width / 15),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              iconSize: 30,
              onPressed: () async {
                // try{
                //   await storage.deleteAll();
                //   Navigator.pushReplacementNamed(context, 'firstpage');
    
                //   }catch(e){
    
                //   Toastmsg(msg: 'Logout Was Failed');
                // }
              },
            ),
          ],
        ),
        body: Padding(padding: EdgeInsets.all(18.0),
        child: Column(
          children: [
          Container(
            height: 45,
            decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(25)),
            child: TabBar(
              indicator: BoxDecoration(color: ui.greyclr,borderRadius: BorderRadius.circular(25)),
              tabs: [
              Tab(text: 'patients'),
              Tab(text: 'hospital',)
            ]),),
            
        ],),),
      ),
    );
  }
}