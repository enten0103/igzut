import 'package:get/get.dart';
import 'package:igzut/service/auth_service.dart';
import 'package:igzut/tools/types.dart';

abstract class CommonController extends GetxController {
  void onLogin();
  @override
  void onReady() async {
    var auth = Get.find<AuthService>();
    if ((await auth.hasLogin) == LoginState.success) {
      onLogin();
    }
    super.onReady();
  }
}
