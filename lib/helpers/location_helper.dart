import 'dart:convert';
import 'package:http/http.dart' as http;


const apiKey = 'pk.eyJ1IjoieWFudG9ndW50ZWwiLCJhIjoiY2s1Yzh4cHlwMWpxYjNsbTdoMnlhNnhpMSJ9.gmEc5DZKlunPxRQIACleXg';

class LocationHelper {   
  static String generatePreviewImageUrl({double latitude, double longitude}) { 
     return 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-l($longitude,$latitude)/$longitude,$latitude,14.25,0,0/600x300?access_token=$apiKey';  
      }
  static Future<String> getPlaceAddress(double latitude, double longitude) async{
    final url ="https://api.mapbox.com/geocoding/v5/mapbox.places/$longitude,$latitude.json?access_token=$apiKey";
    
    final response = await http.get(url);
   return json.decode(response.body)['features'][0]['place_name'];
  }
}

