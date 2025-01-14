import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:igzut/ui/pages/main_page.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(ChangeNotifierProvider(
      create: (_) => GlobalState(), child: const IGZUT()));
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            ColorScheme.fromSeed(seedColor: Colors.blue).surfaceContainer);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
}

class IGZUT extends StatelessWidget {
  const IGZUT({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '教务助手',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
