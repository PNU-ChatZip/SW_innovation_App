// Define the Api class in a file named 'api.dart'
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_map_plugin_example/model/location.dart'; 
class Api {
  final String _baseUrl = dotenv.env["URL"]!; 

  Future<void> sendLocation(location location) async {
    Uri url = Uri.parse('$_baseUrl/send-location'); 

    // try {
      http.Response response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(location.toJson()),
      );

      if (response.statusCode == 200) {
        print('Location sent successfully.');
      } else {
        print('Failed to send location. Status Code: ${response.statusCode}');
      }
    
    // } catch (e) {
    //   print('Error sending location: $e');
    // }
  }

  // Future
}
