import 'package:get/get.dart';
import 'package:igzut/service/auth_service.dart';
import 'package:igzut/tools/types.dart';

class HomeController extends GetxController {
  ///网络状态
  Rx<NetState> netState = NetState.loading.obs;

  ///登录状态
  Rx<LoginState> loginState = LoginState.unlogin.obs;

  @override
  void onInit() async {
    var auth = Get.find<AuthService>();
    netState.value = await auth.netState;
    loginState.value = await auth.hasLogin;
    super.onInit();
  }
}
