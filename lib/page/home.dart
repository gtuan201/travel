import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Xin chào, ${user!.displayName}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Expanded(
                  child: Container(),
                ),
                CircleAvatar(backgroundImage: FileImage(File("${user?.photoURL}")),),
              ],
            ),
        ),
      ),
      body: const Text("hihihii"),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
