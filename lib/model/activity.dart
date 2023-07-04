import 'dart:convert';

import 'package:travel/model/location.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
class Activity {
  String? id;
  String? name;
  Location? location;
  List<String>? listImage;
  List<String>? listComment;
  int? price;
  String? description;
  double? rating;
  int? age;
  String? term;
  String? timeStart;
  int? timing;
  String? type;

  Activity(
      this.id,
      this.name,
      this.location,
      this.listImage,
      this.listComment,
      this.price,
      this.description,
      this.rating,
      this.age,
      this.term,
      this.timeStart,
      this.timing,
      this.type);

  Activity.fromJson(Map<String, dynamic> json) {
    List<dynamic> listImages = json['listImage'] ?? [];
    List<String> images = listImages.cast<String>().toList();
    List<dynamic> listComment = json['listComment'] ?? [];
    List<String> comments = listComment.cast<String>().toList();
    Location locationData = Location.fromJson(json['location']);
    id = json['id'];
    name = json['name'];
    location = locationData;
    listImage = images;
    listComment = comments;
    price = json['price'];
    description = json['description'];
    rating = json['rating'];
    age = json['age'];
    term = json['term'];
    timeStart = json['timeStart'];
    timing = json['timing'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location!.toJson(),
      'listImage': listImage,
      'rating': rating,
      'listComment': listComment,
      'price': price,
      'description': description,
      'age':age,
      'term':term,
      'timeStart':timeStart,
      'timing':timing,
      'type':type
    };
  }
  Future<void> addLocation(Activity activity) async {
    final response = await http.put(
      Uri.parse('${Constants.BASE_URL}/activity/${activity.id}.json'),
      body: json.encode(activity.toJson()),
    );
    if (response.statusCode == 200) {
      print('Data added successfully');
    } else
      print('Data added fail');
  }
}
