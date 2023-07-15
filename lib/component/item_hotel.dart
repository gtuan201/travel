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
          return Wrap(
            children: [
              Stack(
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
                    top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                         decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: const Icon(Icons.favorite_border,size: 18,),
                      )
                  ),
                  Positioned(
                    left: 8,
                      bottom: 8,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                child: Icon(Icons.location_on,color: Colors.white,size: 12,),
                              ),
                            ),
                            TextSpan(text: items[index].location!.name,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12)),
                          ],
                        ),
                      )
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[index].name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    child: RatingBar.builder(
                        itemSize: 12,
                        itemCount: 5,
                        unratedColor: Colors.grey.shade300,
                        initialRating: items[index].rating!,
                        allowHalfRating: false,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {}),
                  )
                ],
              )
            ],
          );
        });
  }

  String getAmount(String? price) {
    String formattedAmount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(int.parse(price!));
    return formattedAmount;
  }
}
