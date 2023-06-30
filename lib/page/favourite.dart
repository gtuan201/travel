import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget{
  const FavouritePage({super.key});

  @override
  State<StatefulWidget> createState() => _FavouriteState();
}
class _FavouriteState extends State<FavouritePage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Fav"),
    );
  }
}