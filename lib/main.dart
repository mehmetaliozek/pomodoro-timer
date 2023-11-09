import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pomodoro_timer/screens/home.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pomodoro Timer',
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}
