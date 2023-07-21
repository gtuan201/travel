import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/page/main_page.dart';
import 'package:travel/page/onboarding_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _determinePosition().then((value) async => {
          saveLocation(value),
          Timer(
              const Duration(seconds: 2),
              () => Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => getWidget(),
                      transitionDuration: const Duration(milliseconds: 800),
                      transitionsBuilder: (_, a, __, c) =>
                          FadeTransition(opacity: a, child: c),
                    ),
                  ))
        });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 92, 153),
      body: Center(child: Image(image: AssetImage('assets/images/logo.png'))),
    );
  }

  Widget getWidget() {
    FirebaseAuth auth = FirebaseAuth.instance;
    var user = auth.currentUser;
    if (user != null) {
      return const MainPage();
    }
    return const OnboardingScreen();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}

saveLocation(Position value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('lat', value.latitude);
  await prefs.setDouble('long', value.longitude);
}