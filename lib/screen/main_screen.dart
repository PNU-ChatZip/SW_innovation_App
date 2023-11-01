import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

import '../api/Restapi.dart';
import '../kakaomap.dart';
import '../model/location.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //press button to send location and show snackbar
  void _printCurrentLocation() async {
    try {
      LatLng currentLocation = await getLocation();
      print("${currentLocation.latitude} ${currentLocation.longitude}");
      location loc = location(currentLocation.latitude.toString(),
          currentLocation.longitude.toString());
      await Api().sendLocation(loc);

      // success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치가 성공적으로 전송되었습니다!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print("Failed to get location: $e");

      // error massage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('위치를 전송을 실패했습니다'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 670,
            child: MyKakaoMap(),
          ),
          Row(
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
                        color: Colors.red,
                        width: 2), // Set border color and width
                  ),
                ),
                child: const Text("포트홀 신고하기"),
              ),
            ],
          )
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: InkWell(
      //     onTap: _printCurrentLocation,
      //     child: Container(
      //       height: kBottomNavigationBarHeight,
      //       width: double.infinity,
      //       alignment: Alignment.center,
      //       child: const Icon(Icons.location_on, size: 28),
      //     ),
      //   ),
      // ),
    );
  }
}
