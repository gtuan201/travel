import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travel/model/location.dart';

import '../utils/constants.dart';

class Hotel {
  String? id;
  String? name;
  List<String>? listImage;
  List<String>? features;
  List<String>? listComment;
  String? lat;
  String? long;
  int? room;
  String? price;
  String? times;
  double? rating;
  String? description;
  int? type;
  Location? location;

  Hotel(
      this.id,
      this.name,
      this.listImage,
      this.features,
      this.listComment,
      this.lat,
      this.long,
      this.room,
      this.price,
      this.times,
      this.rating,
      this.description,
      this.type,
      this.location);

  Hotel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listImages = json['listImage'] ?? [];
    List<String> images = listImages.cast<String>().toList();
    List<dynamic> listComment = json['listComment'] ?? [];
    List<String> comments = listComment.cast<String>().toList();
    List<dynamic> listFeature = json['features'] ?? [];
    List<String> feature = listFeature.cast<String>().toList();
    Location locationData = Location.fromJson(json['location']);
    id = json['id'];
    name = json['name'];
    listImage = images;
    features = feature;
    listComment = comments;
    location = locationData;
    lat = json['lat'];
    long = json['long'];
    room = json['room'];
    price = json['price'];
    times = json['times'];
    rating = json['rating'];
    description = json['description'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'name':name,
      'listImage':listImage,
      'features':features,
      'listComment':listComment,
      'lat':lat,
      'long':long,
      'room':room,
      'price':price,
      'times':times,
      'rating':rating,
      'description':description,
      'type':type,
      'location':location!.toJson()
    };
  }
  Future<void> addLocation(Hotel hotel) async {
    final response = await http.put(
      Uri.parse('${Constants.BASE_URL}/hotel/${hotel.id}.json'),
      body: json.encode(hotel.toJson()),
    );
    if (response.statusCode == 200) {
      print('Data added successfully');
    } else
      print('Data added fail');
  }
}
