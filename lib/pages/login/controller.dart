import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  /// 清理所有数据并重置Controller
  Future<void> resetAllControllers() async {
    // 清除本地存储
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.deleteAll();
  }

  @override
  void onInit() {
    super.onInit();
    resetAllControllers();
  }
}
