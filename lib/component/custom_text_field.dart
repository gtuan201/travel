
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        enabled: false,
        hintText: "Khám phá những vùng đất mới...",
        hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 0.0),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.search),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.transparent),
        )
      ),
    );
  }
}