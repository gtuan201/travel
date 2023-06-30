import 'dart:ui';

import 'package:flutter/material.dart';

class Onboarding {
  String title;
  String image;
  String description;
  Color background;

  Onboarding(this.title, this.image,this.description , this.background);
}
List<Onboarding> contentsList = [
  Onboarding("Sánh vai cùng những người bạn yêu du lịch", 'assets/images/onb3.png', 'Beautiful One Day, Perfect The Next',const Color(
      0xfffdd5d5)),
  Onboarding("Điểm đến thú vị, vui chơi thỏa thích", 'assets/images/onb1.png','Adventure Awaits, Go Find It', const Color(
      0xfffde0c1)),
  Onboarding("Làm hết mình, chơi hết tầm", 'assets/images/onb2.png','A Destination For The New Millennium', const Color(
      0xfffff2b9)),
];
