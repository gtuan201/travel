import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travel/model/activity.dart';
import 'package:travel/model/hotel.dart';
import 'package:travel/model/location.dart';
import 'package:intl/intl.dart';

class ItemHotel extends StatelessWidget {
  final List<Hotel> items;

  const ItemHotel({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
        itemCount: items.length,
        controller: ScrollController(),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: InkWell(
                  onTap: () {},
                  child: CachedNetworkImage(
                    imageUrl: items[index].listImage?[0] ?? "",
                    placeholder: (context, url) => const Center(
                      child: SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            color: Colors.black26,
                          )),
                    ),
                    errorWidget: (context, url, error) => const Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error,
                          color: Colors.grey,
                        ),
                        Text(
                          "Lỗi tải hình ảnh",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        )
                      ],
                    )),
                  ),
                ),
              ),
              Positioned(
                  bottom: 6,
                  left: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index].name!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      SizedBox(
                        child: RatingBar.builder(
                            itemSize: 12,
                            itemCount: 5,
                            unratedColor: Colors.white54,
                            initialRating: items[index].rating!,
                            allowHalfRating: false,
                            ignoreGestures: true,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {}),
                      ),
                      Text(getAmount(items[index].price), style: const TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),)
                    ],
                  )),
            ],
          );
        });
  }
  String getAmount(String? price){
    String formattedAmount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(int.parse(price!));
    return formattedAmount;
  }
}
