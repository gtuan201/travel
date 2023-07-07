import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class ItemHotelLoading extends StatelessWidget{
  const ItemHotelLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      itemCount: 6,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: (index % 2 == 0)? const EdgeInsets.only(right: 4,bottom: 8) : const EdgeInsets.only(left: 4,bottom: 8),
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
}