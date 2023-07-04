
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:travel/component/custom_text_field.dart';
import 'package:badges/badges.dart' as badges;
import 'package:travel/component/item_activities.dart';
import 'package:travel/component/item_nearby_location.dart';
import 'package:travel/component/layout_service_button.dart';
import 'package:travel/data/api.dart';
import 'package:travel/model/activity.dart';

import '../model/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;
  final ScrollController _controller = ScrollController();

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
              Opacity(
                opacity: 1,
                child: Row(
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
                    GestureDetector(
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
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/image_avatar.jpg'),
                      radius: 16,
                    )
                  ],
                ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Địa điểm du lịch phổ biến",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(),
                  const Text("Xem thêm",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                ],
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
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Các hoạt động đang diễn ra",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(),
                  const Text("Xem thêm",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 220,
                child: FutureBuilder<List<Activity>>(
                  future: Api().getActivities(),
                  builder: (BuildContext context, AsyncSnapshot<List<Activity>> snapshot){
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
                                  width: 240,
                                  height: 180,
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
                    else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: (index != snapshot.data!.length - 1)? const EdgeInsets.only(right: 10) : EdgeInsets.zero,
                              child: ItemActivities(activity: snapshot.data![index],),
                            );
                          }
                      );
                    }
                  },
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
    _controller.addListener(_scrollListener);
    // loadUsers();
    // int id = DateTime.now().millisecondsSinceEpoch;
    // Location location = new Location("$id", "Bangkok,", "Thái Lan", ["https://i.pinimg.com/564x/e6/96/4c/e6964c3dff924dffb0f2bef45eea133c.jpg"], 5.0, [], 13.782598, 100.525696, 1000000,"des");
    // location.addLocation(location);
    // Activity activity = new Activity("${id + 10}", "Lễ Hội Té Nước", location, ["https://i.pinimg.com/564x/29/e7/d1/29e7d1983e49f493a3ecfc3250cd8e10.jpg"], [], 500000, "description", 4, 17, "term", "04/07/2023", 60, "Ngoài trời");
    // activity.addLocation(activity);
    super.initState();
  }
  void _scrollListener() {
    if (_controller.position.pixels >= 1 && _controller.position.pixels <= 60) {

    }
  }
}