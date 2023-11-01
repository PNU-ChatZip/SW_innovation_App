import 'package:flutter/material.dart';
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
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 670,
            child: MyKakaoMap(),
          ),
          BottomTab(),
        ],
      ),
    );
  }
}
