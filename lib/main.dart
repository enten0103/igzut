import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:igzut/ui/pages/main_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '教务助手',
      builder: FToastBuilder(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white54),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
