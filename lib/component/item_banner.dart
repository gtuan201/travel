import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemBanner extends StatelessWidget {
  final String url;
  const ItemBanner({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 100,
        color: Colors.grey.shade200,
        child: CachedNetworkImage(
          imageBuilder: (context, imageProvider) => Container(
              width: 240,
              height: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider, fit: BoxFit.cover))),
          imageUrl: url,
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
    );
  }
}
