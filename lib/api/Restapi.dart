// Define the Api class in a file named 'api.dart'
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:kakao_map_plugin_example/kakaomap.dart';
import 'package:kakao_map_plugin_example/model/location.dart'; 
class Api {
  final String _baseUrl = dotenv.env["URL"]!; 
  Future<void> sendCurrentLocation(String type) async {
  try {
    LatLng currentLocation = await getLocation();
    print("${currentLocation.latitude} ${currentLocation.longitude}");
    
    // Creating the location object.
    var loc = location(
      currentLocation.latitude.toString(),
      currentLocation.longitude.toString(), 
      type, 
      DateTime.now().toIso8601String()
    );
    
    // Creating the URL.
    Uri url = Uri.parse('$_baseUrl/send-location');
    
    // Sending the HTTP request.
    http.Response response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loc.toJson()),
    );
    
    // Handling the response.
    if (response.statusCode == 200) {
      print('Location sent successfully.');
    } else {
      print('Failed to send location. Status Code: ${response.statusCode}');
      throw Exception('Failed to send location. Status Code: ${response.statusCode}');
    }
    
  } catch (e) {
    print('Failed to send location: $e');
    // Here you would handle the error, e.g., showing a snackbar if this is a Flutter app.
    // Since the context is not passed to this function, you cannot show a Snackbar directly here.
  }
}
  // Future<void> sendLocation(location location) async {
  //   Uri url = Uri.parse('$_baseUrl/send-location'); 

  //   // try {
  //     http.Response response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: jsonEncode(location.toJson()),
  //     );

  //     if (response.statusCode == 200) {
  //       print('Location sent successfully.');
  //     } else {
  //       print('Failed to send location. Status Code: ${response.statusCode}');
  //     }
    
  //   // } catch (e) {
  //   //   print('Error sending location: $e');
  //   // }
  // }

  // Future<List<location>> receiveLocation() async {
  //   Uri url = Uri.parse('$_baseUrl/receive-location'); 

  //   try {
  //     http.Response response = await http.get(url);

  //     if (response.statusCode == 200) {
  //       List<dynamic> body = jsonDecode(response.body);
  //       List<location> locations =
  //           body.map((dynamic item) => location.fromJson(item)).toList();
  //       print(locations);
  //       return locations;
  //     } else {
  //       print('Failed to load location. Status Code: ${response.statusCode}');
  //       return <location>[];
  //     }
  //   } catch (e) {
  //     print('Error loading location: $e');
  //     return <location>[];
  //   }
  // }

  // Future
}
