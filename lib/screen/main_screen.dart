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
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 600,
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
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text('포트홀'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text('도로 막힘'),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {},
                                    child: Text('차량 사고'),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                child: const Text('Close BottomSheet'),
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
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(12), // Set padding for all sides
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16), // Set the font size
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                        color: Colors.blue,
                        width: 2), // Set border color and width
                  ),
                ),
                child: const Text("신고하기"),
              ),
              OutlinedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 600,
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              width: 300,
                              child: TextField(
                                decoration: InputDecoration(hintText: "출발지"),
                              ),
                            ),
                            const SizedBox(
                              width: 300,
                              child: TextField(
                                decoration: InputDecoration(hintText: "목적지"),
                              ),
                            ),
                            ElevatedButton(
                              child: const Text('Close BottomSheet'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(12), // Set padding for all sides
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16), // Set the font size
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                        color: Colors.blue,
                        width: 2), // Set border color and width
                  ),
                ),
                child: const Text("길찾기"),
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
