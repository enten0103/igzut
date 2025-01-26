import 'package:get/get.dart';
import 'package:igzut/pages/login/controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
