import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin_example/api/Restapi.dart';
import 'package:kakao_map_plugin_example/screen/record_screen.dart';
import 'package:kakao_map_plugin_example/service/notification.dart';
import 'package:kakao_map_plugin_example/widget/BottomTab.dart';

import '../kakaomap.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final NotificationManager notificationManager = NotificationManager();
  @override
  void initState() {
    super.initState();
    notificationManager.initNotifications();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "B map",
              style: TextStyle(
                color: Color.fromRGBO(143, 148, 251, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RecordScreen(),
                  ),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(fontSize: 16), // Set the font size
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(143, 148, 251, 1),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                side: MaterialStateProperty.all<BorderSide>(
                  const BorderSide(
                      color: Color.fromRGBO(143, 148, 251, 1),
                      width: 2), // Set border color and width
                ),
              ),
              child: const Text(
                "신고기록",
                style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 550,
            width: 400,
            child: MyKakaoMap(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (await DashBubble.instance.hasOverlayPermission()) {
                    DashBubble.instance.startBubble(
                      bubbleOptions: BubbleOptions(
                        bubbleIcon: "porthole",
                        bubbleSize: 150,
                        distanceToClose: 100,
                        enableClose: false,
                        startLocationX: 250,
                        startLocationY: 500,
                      ),
                      onTap: () {
                        print("click bubble");
                        Api().sendCurrentLocation("포트홀");
                        notificationManager.showNotification();
                      },
                      notificationOptions: NotificationOptions(
                        title: "b map title",
                        body: "b map body",
                      ),
                    );
                  } else {
                    await DashBubble.instance.requestOverlayPermission();
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 40.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16), // Set the font size
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(143, 148, 251, 1),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(143, 148, 251, 1),
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        width: 2), // Set border color and width
                  ),
                ),
                child: const Text(
                  "시작하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  DashBubble.instance.stopBubble();
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 40.0),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(fontSize: 16), // Set the font size
                  ),
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.redAccent,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.redAccent,
                  ),
                  side: MaterialStateProperty.all<BorderSide>(
                    const BorderSide(
                        color: Colors.red,
                        width: 2), // Set border color and width
                  ),
                ),
                child: const Text(
                  "종료하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
