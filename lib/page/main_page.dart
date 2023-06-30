
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel/page/favourite.dart';
import 'package:travel/page/home.dart';
import 'package:travel/page/login.dart';
import 'package:travel/page/splash_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    HomePage(),
    FavouritePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white54,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(height: 1,color: Colors.grey.shade300,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: GNav(
                onTabChange: (index){
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                backgroundColor: Colors.white54,
                color: Colors.black,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.all(10),
                gap: 8,
                tabs: const [
                  GButton(icon: Icons.home_outlined, text: "Trang chủ",backgroundColor: Color(
                      0xfffcd7d3),textColor: Color(0xffff6b5a),iconActiveColor: Color(0xffff6b5a),),
                  GButton(icon: Icons.favorite_border, text: "Yêu thích",backgroundColor: Color(
                      0xffd7f1fd),textColor: Color(0xff4db2e3),iconActiveColor: Color(0xff5db8e3),),
                  GButton(icon: Icons.search_sharp, text: "Tìm kiếm",backgroundColor: Color(
                      0xffeacfff),textColor: Color(0xffc370da),iconActiveColor: Color(0xffc370da),),
                  GButton(icon: Icons.person_2_outlined, text: "Hồ sơ",backgroundColor: Color(
                      0xfffdd7b4),textColor: Color(0xffCC7F3B),iconActiveColor: Color(0xffCC7F3B),),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        bottom: false,
        child:  pages[_selectedIndex],
      )
    );
  }
}
