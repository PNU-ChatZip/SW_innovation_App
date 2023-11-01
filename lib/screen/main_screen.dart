import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_apps/flutter_overlay_apps.dart';
import 'package:kakao_map_plugin_example/api/Restapi.dart';
import 'package:kakao_map_plugin_example/widget/BottomTab.dart';

import '../kakaomap.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (await DashBubble.instance.hasOverlayPermission()) {
                    DashBubble.instance.startBubble(
                      bubbleOptions: BubbleOptions(
                        bubbleIcon: "porthole",
                        bubbleSize: 200,
                        distanceToClose: 100,
                        enableClose: false,

                      ),
                      onTap: () {
                        print("click bubble");
                        Api().sendCurrentLocation("포트홀");
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
                child: const Text("버튼 오버레이"),
              ),
              ElevatedButton(
                onPressed: () async {
                  DashBubble.instance.stopBubble();
                },
                child: const Text("종료하기"),
              ),
            ],
          ),
          Container(
            height: 400,
            width: 400,
            child: MyKakaoMap(),
          ),
          // BottomTab(),
        ],
      ),
    );
  }
}
