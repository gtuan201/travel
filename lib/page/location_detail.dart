import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:maps_toolkit/maps_toolkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel/component/custom_icon_button.dart';
import 'package:travel/model/location.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:latlong2/latlong.dart' as LatLong;
import 'package:flutter_map/plugin_api.dart';
import 'package:intl/intl.dart';

class LocationDetail extends StatefulWidget {
  const LocationDetail({super.key});

  @override
  State<StatefulWidget> createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail>  with SingleTickerProviderStateMixin{
  ScrollController _scrollController = ScrollController();
  // final YoutubePlayerController _controller = YoutubePlayerController(
  //   initialVideoId: 'YMx8Bbev6T4',
  //   flags: const YoutubePlayerFlags(
  //     autoPlay: false,
  //     forceHD: true,
  //     mute: false,
  //   ),
  // );
  var opacity = 0.0.obs;
  @override
  void initState() {
    _scrollController.addListener(() {showAppBar();});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Location location = Get.arguments;
    var activeIndex = 0.obs;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider(
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
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                        color: Colors.deepOrangeAccent),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 8),
                                      child: Text(
                                        'Ưu đãi độc quyền',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    location.name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: Colors.grey.shade700,
                                      ),
                                      Text(
                                        " ${location.country}",
                                        style: TextStyle(color: Colors.grey.shade700),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Icon(
                                        Icons.speed,
                                        size: 12,
                                        color: Colors.grey.shade700,
                                      ),
                                      FutureBuilder(
                                          future: distanceBetweenPoints(
                                              location.lat, location.long),
                                          builder: (context, snapshot) => Text(
                                              " ${snapshot.data} km",
                                              style: TextStyle(
                                                  color: Colors.grey.shade700))),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 110,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  clipBehavior: Clip.hardEdge,
                                  borderRadius: BorderRadius.circular(10),
                                  child: FlutterMap(
                                    options: MapOptions(
                                      interactiveFlags: InteractiveFlag.none,
                                      center: LatLong.LatLng(location.lat, location.long),
                                      zoom: 1,
                                    ),
                                    nonRotatedChildren: [
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point: LatLong.LatLng(location.lat, location.long),
                                            width: 60,
                                            height: 60,
                                            builder: (context) => const Icon(Icons.location_on,color: Colors.red,),
                                          ),
                                        ],
                                      ),
                                    ],
                                    children: [
                                      TileLayer(
                                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        userAgentPackageName: 'com.example.app',
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    location.rating.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 20,
                                  ),
                                  Text(
                                      " / ${location.listComment.length} đánh giá"),
                                ],
                              ),
                              TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Xem đánh giá",
                                        style: TextStyle(
                                            color: Colors.deepOrangeAccent),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 15,
                                        color: Colors.deepOrangeAccent,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Color(0x9BC6EDFF)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icon/sale.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      'Chúng tôi đã so sánh giá thấp nhất từ 3 nhà cung cấp khác!',
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.visible,
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 8,
                      color: Colors.grey.shade200,
                      thickness: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpandableText(
                            location.description,
                            style: const TextStyle(color: Colors.black87),
                            expandText: 'Xem thêm',
                            collapseText: 'Thu gọn',
                            maxLines: 4,
                            linkColor: Colors.blue,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const Text(
                            'Tiện nghi',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomIconButton(
                                    iconPath: 'assets/icon/car2.svg',
                                    color: Colors.black87,
                                    title: 'Cho thuê xe'),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomIconButton(
                                    iconPath: 'assets/icon/restaurant.svg',
                                    color: Colors.black87,
                                    title: 'Đồ ăn miễn phí'),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomIconButton(
                                    iconPath: 'assets/icon/house.svg',
                                    color: Colors.black87,
                                    title: 'Phòng rộng rãi'),
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomIconButton(
                                    iconPath: 'assets/icon/ship.svg',
                                    color: Colors.black87,
                                    title: 'Du thuyền'),
                              ),
                            ],
                          ),
                          const Divider(),
                          const Text(
                            'Video giới thiệu',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          // YoutubePlayer(
                          //   controller: _controller,
                          //   showVideoProgressIndicator: true,
                          //   onReady: (){
                          //     print("ready");
                          //   },
                          // ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 58),
                              child: Stack(
                                children: [
                                  Image.network(
                                      'https://img.youtube.com/vi/ZhT3g1pqdjc/maxresdefault.jpg'),
                                  const Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.play_circle_fill_sharp,
                                        size: 50,
                                        color: Color(0xD5333333),
                                      ))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(() => Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(opacity.value),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, height*0.06, 16, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){Navigator.pop(context);},
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x9EA2A2A2),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Text(location.name,style: TextStyle(color: Colors.black.withOpacity(opacity.value),fontSize: 16,fontWeight: FontWeight.bold),),
                    const Spacer(),
                    GestureDetector(
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x9EA2A2A2),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),)
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(spreadRadius: 0.1, blurRadius: 1, color: Colors.grey)
              ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Giá: ${getAmount(location.price*1.2)}',style: const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 14,color: Colors.deepOrange,fontWeight: FontWeight.bold,decorationThickness: 2,decorationColor: Colors.deepOrange),),
                                const SizedBox(width: 6,),
                                Container(
                                  color: Colors.deepOrange,
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 4,vertical: 2),
                                    child: Text('20%',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w900),),
                                  ),
                                )
                              ],
                            ),
                            Text('Giá: ${getAmount(location.price)}/người',style: const TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          child: const Text('Đặt Tour',style: TextStyle(color: Colors.white,fontSize: 16),)
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
      )
    );
  }

  Future<String> distanceBetweenPoints(double lat, double long) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? currentLat = prefs.getDouble('lat');
    double? currentLong = prefs.getDouble('long');
    num distance = SphericalUtil.computeDistanceBetween(
        LatLng(currentLat ?? 0, currentLong ?? 0), LatLng(lat, long));
    var value = distance / 1000;
    return value.toInt().toString();
  }

  void showAppBar(){
    if(_scrollController.position.pixels <= 290){
      opacity.value = _scrollController.position.pixels/290;
    }
  }
  String getAmount(dynamic price) {
    String formattedAmount = NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
        .format(price);
    return formattedAmount;
  }
  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }
}
