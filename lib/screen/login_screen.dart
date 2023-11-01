import 'package:flutter/material.dart';
import 'package:kakao_map_plugin_example/screen/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "ID",
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "PASSWORD",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MainScreen()));
                },
                child: Text("login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
