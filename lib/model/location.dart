import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel/utils/constants.dart';

class Location {
  String? _id;
  String? _name;
  String? _country;
  List<String>? _listImage;
  double? _rating;
  List<String>? _listComment;
  double? _lat;
  double? _long;
  int? _price;
  String? _description;

  Location(this._id, this._name, this._country, this._listImage, this._rating,
      this._listComment, this._lat, this._long, this._price, this._description);

  Location.fromJson(Map<String, dynamic> json) {
    List<dynamic> listImages = json['listImage'] ?? [];
    List<String> images = listImages.cast<String>().toList();
    List<dynamic> listComment = json['listComment'] ?? [];
    List<String> comments = listComment.cast<String>().toList();
    _id = json['id'];
    _name = json['name'];
    _country = json['country'];
    _listImage = images;
    _rating = json['rating'];
    _listComment = comments;
    _lat = json['lat'];
    _long = json['long'];
    _price = json['price'];
    _description = json['description'];
  }

  String get id => _id ?? "";

  set id(String value) {
    _id = value;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'country': _country,
      'listImage': _listImage,
      'rating': _rating,
      'listComment': _listComment,
      'lat': _lat,
      'long': _long,
      'price': _price,
      'description': _description
    };
  }

  Future<void> addLocation(Location location) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    location._id = id;
    final response = await http.put(
      Uri.parse('${Constants.BASE_URL}/location/${location._id}.json'),
      body: json.encode(location.toJson()),
    );
    if (response.statusCode == 200) {
      print('Data added successfully');
    } else
      print('Data added fail');
  }
  @override
  String toString() {
    return "${_name}";
  }

  String get name => _name ?? "";

  set name(String value) {
    _name = value;
  }

  String get country => _country ?? "";

  set country(String value) {
    _country = value;
  }

  List<String> get listImage => _listImage ?? [];

  set listImage(List<String> value) {
    _listImage = value;
  }

  double get rating => _rating ?? 0;

  set rating(double value) {
    _rating = value;
  }

  List<String> get listComment => _listComment ?? [];

  set listComment(List<String> value) {
    _listComment = value;
  }

  double get lat => _lat ?? 0;

  set lat(double value) {
    _lat = value;
  }

  double get long => _long ?? 0;

  set long(double value) {
    _long = value;
  }

  int get price => _price ?? 0;

  set price(int value) {
    _price = value;
  }

  String get description => _description ?? "";

  set description(String value) {
    _description = value;
  }
}
