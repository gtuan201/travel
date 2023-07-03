import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

class ServiceButtons extends StatelessWidget{
  const ServiceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(iconPath: 'assets/icon/hotel.svg', color: Colors.lightBlue,title: 'Khách Sạn',),
            CustomIconButton(iconPath: 'assets/icon/house.svg', color: Colors.orange,title: 'HomeStay',),
            CustomIconButton(iconPath: 'assets/icon/airplane.svg', color: Colors.blue,title: 'Vé máy bay',),
            CustomIconButton(iconPath: 'assets/icon/train.svg', color: Colors.purple,title: 'Vé tàu',),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(iconPath: 'assets/icon/car.svg', color: Colors.redAccent,title: 'Thuê xe',),
            CustomIconButton(iconPath: 'assets/icon/ship.svg', color: Colors.indigoAccent,title: 'Du thuyền',),
            CustomIconButton(iconPath: 'assets/icon/taxi.svg', color: Colors.brown,title: 'Taxi',),
            CustomIconButton(iconPath: 'assets/icon/restaurant.svg', color: Colors.teal,title: 'Nhà hàng',),
          ],
        ),
      ],
    );
  }
}