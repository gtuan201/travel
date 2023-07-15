import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travel/model/location.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animations/animations.dart';

class LocationDetail extends StatefulWidget {
  const LocationDetail({super.key});

  @override
  State<StatefulWidget> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Location location = Get.arguments;
    var activeIndex = 0.obs;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'location',
                child: CarouselSlider(
                  items: location.listImage.map((i) {
                    return Builder(builder: (BuildContext context) {
                      return CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageUrl: i,
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
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            )
                          ],
                        )),
                      );
                    });
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      activeIndex.value = index;
                    },
                    autoPlay: false,
                    height: 300,
                  ),
                ),
              ),
              Obx(() => Positioned(
                    top: 0,
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex.value,
                        count: location.listImage.length,
                        effect: const WormEffect(
                          dotColor: Colors.white,
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Colors.grey,
                        ),
                      ),
                    ),
                  )),
              Obx(() => Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0x9EA2A2A2)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Text(
                          "${activeIndex.value + 1}/${location.listImage.length}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      )))),
              Positioned(
                top: height*0.045,
                  left: 16,
                  child: GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x9EA2A2A2),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.arrow_back_rounded,color: Colors.white,size: 20,),
                      ),
                    ),
                  )
              ),
              Positioned(
                  top: height*0.045,
                  right: 16,
                  child: GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0x9EA2A2A2),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.favorite_border,color: Colors.white,size: 20,),
                      ),
                    ),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
