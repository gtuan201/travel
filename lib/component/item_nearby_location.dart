import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel/model/location.dart';

class ItemNearbyLocation extends StatelessWidget {
  final Location location;
  const ItemNearbyLocation({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(
                      width: 150,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover))),
                  imageUrl: location.listImage[0],
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
                Positioned(
                    bottom: 6,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          location.name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                        Row(
                          children: [
                            Text(
                              location.country,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11),
                            ),
                            const SizedBox(width: 4,),
                            const Icon(Icons.location_on,size: 12,color: Colors.white,)
                          ],
                        ),
                        SizedBox(
                          child: RatingBar.builder(
                              itemSize: 12,
                              itemCount: 5,
                              unratedColor: Colors.white54,
                              initialRating: 3,
                              itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                              onRatingUpdate: (rating) {}),
                        )
                      ],
                    )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
