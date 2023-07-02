import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel/page/favourite.dart';
import 'package:travel/page/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    HomePage(),
    FavouritePage(),
    HomePage(),
    FavouritePage(),
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
                color: Colors.black54,
                activeColor: Colors.white,
                tabBackgroundColor: Colors.grey.shade800,
                padding: const EdgeInsets.all(10),
                gap: 8,
                tabs: const [
                  GButton(icon: Icons.home_outlined, text: "Trang chủ",backgroundColor: Color(
                      0xffd7f1fd),textColor: Color(0xff4db2e3),iconActiveColor: Color(0xff5db8e3),),
                  GButton(icon: Icons.travel_explore, text: "Khám phá",backgroundColor: Color(
                      0xffd7f1fd),textColor: Color(0xff4db2e3),iconActiveColor: Color(0xff5db8e3),),
                  GButton(icon: Icons.favorite_border, text: "Yêu thích",backgroundColor: Color(
                      0xffd7f1fd),textColor: Color(0xff4db2e3),iconActiveColor: Color(0xff5db8e3),),
                  GButton(icon: Icons.search_sharp, text: "Tìm kiếm",backgroundColor: Color(
                      0xffd7f1fd),textColor: Color(0xff4db2e3),iconActiveColor: Color(0xff5db8e3),),
                  GButton(icon: Icons.person_2_outlined, text: "Tài khoản",backgroundColor: Color(
                      0xffd7f1fd),textColor: Color(0xff4db2e3),iconActiveColor: Color(0xff5db8e3),),
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
