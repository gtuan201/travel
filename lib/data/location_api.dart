import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel/model/location.dart';
import 'package:travel/utils/constants.dart';
class Api {
  Future<List<Location>> getLocations() async {
    const String url = "${Constants.BASE_URL}/location.json";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> responseData = json.decode(response.body);
      List<Map<dynamic, dynamic>> users = [];
      responseData.forEach((key, value) {
        users.add({...value, 'id': key});
      });
      List<Location> locations = [];
      responseData.forEach((key, value) {
        locations.add(Location.fromJson({...value, 'id': key}));
      });
      return locations;
    } else {
      throw Exception('Failed to load users');
    }
  }
}