import 'package:get/get.dart';
import 'package:igzut/bingings/index_binding.dart';
import 'package:igzut/bingings/login_binding.dart';
import 'package:igzut/pages/index/view.dart';
import 'package:igzut/pages/login/view.dart';

class RouteConfig {
  static const String indexPage = "/index";
  static const String loginPage = "/loginPage";
  static final List<GetPage> getPages = [
    GetPage(
        name: indexPage, page: () => const Index(), binding: IndexBinding()),
    GetPage(name: loginPage, page: () => LoginPage(), binding: LoginBinding())
  ];
}
