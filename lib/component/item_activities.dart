import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travel/model/activity.dart';
import 'package:intl/intl.dart';

class ItemActivities extends StatelessWidget {
  final Activity activity;
  const ItemActivities({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          direction: Axis.vertical,
            children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                width: 240,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                          width: 240,
                          height: 180,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover))),
                      imageUrl: activity.listImage![0],
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
                  ],
                ),
              )
          ),
        ]),
        Text("${activity.name}",style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 14),),
        Text(getAmount(activity.price),style: TextStyle(color: Colors.deepOrange),),
      ],
    );
  }
  String getAmount(int? price){
    String formattedAmount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(price);
    return formattedAmount;
  }
}
