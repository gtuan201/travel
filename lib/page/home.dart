import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:travel/component/custom_text_field.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;
  final List<String> texts = [
    'Text 1',
    'Text 2',
    'Text 3',
    'Text 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          child: Column(
            children: [
               Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Lavana',
                      style: TextStyle(color: Colors.white,fontFamily: 'Belanosima-SemiBold',fontSize: 26),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: GestureDetector(
                      onTap: () {
                        // Xử lý khi người dùng nhấn vào nút
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child:  const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: badges.Badge(
                            badgeContent: Text('1',style: TextStyle(color: Colors.white),),
                            child: Icon(Icons.notifications_none,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: CircleAvatar(
                      backgroundImage: FileImage(File("${user!.photoURL}")),radius: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: CustomTextField(),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: GestureDetector(
                      onTap: () {
                        // Xử lý khi người dùng nhấn vào nút
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child:  const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: badges.Badge(
                            badgeContent: Text('1',style: TextStyle(color: Colors.white),),
                            child: Icon(Icons.notifications_none,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: CircleAvatar(
                      backgroundImage: FileImage(File("${user!.photoURL}")),radius: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[];
        },
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Flexible(
                child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(20.9084384, 107.0682782 ),
                      zoom: 9.2,
                    ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
