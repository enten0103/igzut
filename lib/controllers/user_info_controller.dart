import 'package:get/state_manager.dart';
import 'package:igzut/controllers/common_controller.dart';
import 'package:igzut/service/account_service.dart';

class UserInfoController extends CommonController {
  var name = "--".obs;
  var studentNumber = "--".obs;
  var administrativeClass = "--".obs;
  var college = "--学院".obs;
  @override
  void onInit() async {
    var accountInfo = await AccountService().getAccountInfo();
    if (accountInfo != null) {
      name.value = accountInfo.name;
      studentNumber.value = accountInfo.studentNumber;
      administrativeClass.value = accountInfo.administrativeClass;
      college.value = accountInfo.college;
    }
    super.onInit();
  }

  @override
  void onLogin() async {
    var accountInfo = await AccountService().updateAccountInfo();
    name.value = accountInfo.name;
    studentNumber.value = accountInfo.studentNumber;
    administrativeClass.value = accountInfo.administrativeClass;
    college.value = accountInfo.college;
  }
}
