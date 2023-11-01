import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import '../api/Restapi.dart';
import '../kakaomap.dart';
import '../model/location.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  // A list to hold the received locations
  List<location> _receivedLocations = [];

  //retrieve locations from server
  void _retrieveLocations() async {
    try {
      List<location> locations = await Api().receiveLocation();
      // Use setState to update the UI with the received locations
      setState(() {
        _receivedLocations = locations;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to retrieve locations: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  //press button to send location and show snackbar
  void _printCurrentLocation(String type) async {
    try {
      LatLng currentLocation = await getLocation();
      print("${currentLocation.latitude} ${currentLocation.longitude}");
      location loc = location(currentLocation.latitude.toString(),
          currentLocation.longitude.toString(), type);
      await Api().sendLocation(loc);

      // success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('위치가 성공적으로 전송되었습니다!'),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.blue,
            dismissDirection: DismissDirection.up,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              left: 10,
              right: 10,
            ),
          ),
        );
      }
    } catch (e) {
      print("Failed to get location: $e");

      // error massage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('위치를 전송을 실패했습니다'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
          dismissDirection: DismissDirection.up,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 100,
            left: 10,
            right: 10,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        OutlinedButton(
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 200,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _printCurrentLocation("포트홀");
                              },
                              child: Text("포트홀"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _printCurrentLocation("도로 막힘");
                              },
                              child: Text("도로 막힘"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _printCurrentLocation("차량 사고");
                              },
                              child: Text("차량 사고"),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          child: const Text('확인'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 100.0), // Set padding for all sides
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(fontSize: 16), // Set the font size
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
            overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                  color: Colors.red, width: 2), // Set border color and width
            ),
          ),
          child: const Text("신고하기"),
        ),
      ],
    );
  }
}
