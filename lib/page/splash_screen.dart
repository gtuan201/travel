import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/main.dart';
import 'package:travel/page/main_page.dart';
import 'package:travel/page/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => getWidget(),
                transitionDuration: const Duration(milliseconds: 800),
                transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a,child: c),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 92, 153),
      body: Center(child: Image(image: AssetImage('assets/images/logo.png'))),
    );
  }
  Widget getWidget(){
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    if(user != null){
      return const MainPage();
    }
    return const OnboardingScreen();
  }
}
