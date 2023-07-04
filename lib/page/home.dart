
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel/component/custom_text_field.dart';
import 'package:badges/badges.dart' as badges;
import 'package:travel/component/item_nearby_location.dart';
import 'package:travel/component/layout_service_button.dart';
import 'package:travel/data/location_api.dart';

import '../model/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;
  List<Location> _location = [];
  final ScrollController _controller = ScrollController();
  // Location location = new Location("", "Maldives,", "Cộng hòa Maldives", ["https://i.pinimg.com/564x/1f/7b/62/1f7b621d6320062d76f6d1495200a754.jpg"], 3.0, [], -0.658112, 73.107988, 4000000,"des");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Lavana',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Belanosima-SemiBold',
                          fontSize: 26),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: GestureDetector(
                      onTap: () {
                        loadUsers();
                        // Xử lý khi người dùng nhấn vào nút
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: badges.Badge(
                            badgeContent: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Visibility(
                    visible: true,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/image_avatar.jpg'),
                      radius: 16,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: badges.Badge(
                            badgeContent: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: CircleAvatar(
                      backgroundImage: FileImage(File("${user!.photoURL}")),
                      radius: 16,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ServiceButtons(),
              Divider(
                height: 0.5,
                color: Colors.grey.shade300,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Các địa điểm du lịch gần bạn",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder<List<Location>>(
                  future: Api().getLocations(),
                  builder: (BuildContext context, AsyncSnapshot<List<Location>> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return  Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Shimmer(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Colors.white, Colors.grey.shade300, Colors.white],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(
                                  width: 150,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    else if(snapshot.hasError){
                      return Text('Error: ${snapshot.error}');
                    }
                    else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: (index != snapshot.data!.length - 1)? const EdgeInsets.only(right: 10) : EdgeInsets.zero,
                                child: ItemNearbyLocation(location: snapshot.data![index],)
                            );
                          }
                      );
                    }
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    loadUsers();
    super.initState();
  }
  void loadUsers() async {
    List<Location> locations = await Api().getLocations();
    setState(() {
      _location = locations;
    });
  }
}