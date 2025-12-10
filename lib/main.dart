import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:get/get.dart';
import 'package:igzut/route/route.dart';
import 'package:igzut/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const IGZUT());
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
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
    return GetMaterialApp(
      title: '教务助手',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        fontFamily: "NotoSerif",
        useMaterial3: true,
      ),
      initialRoute: RouteConfig.indexPage,
      getPages: RouteConfig.getPages,
      onInit: () {
        var authService = Get.put(AuthService());
        authService.tryLogin();
      },
    );
  }
}
