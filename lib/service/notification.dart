import 'package:dash_bubble/dash_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kakao_map_plugin_example/api/Restapi.dart';

// 알림을 설정하고 관리하기 위한 클래스
class NotificationManager {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // 알림 초기화
  void initNotifications() {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 오버레이 버튼을 눌렀을 때 호출될 알림 보내기 메서드
  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      '알림',
      '포트홀이 신고되었습니다!',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }
}

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
    // ... 기존 위젯 코드 생략 ...

    return Scaffold(
      body: Column(
        // ... 기존 레이아웃 코드 생략 ...
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (await DashBubble.instance.hasOverlayPermission()) {
                    DashBubble.instance.startBubble(
                      // ... 기존 DashBubble 설정 코드 생략 ...
                      onTap: () {
                        print("click bubble");
                        Api().sendCurrentLocation("포트홀");
                        // 알림을 보내는 코드를 여기에 추가합니다.
                        notificationManager.showNotification();
                      },
                      // ... 기존 코드 생략 ...
                    );
                  } else {
                    await DashBubble.instance.requestOverlayPermission();
                  }
                },
                child: const Text("버튼 오버레이"),
              ),
              // ... 기존 ElevatedButton 코드 생략 ...
            ],
          ),
          // ... 나머지 위젯 코드 생략 ...
        ],
      ),
    );
  }
}





