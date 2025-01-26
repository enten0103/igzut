import 'package:get/get.dart';

class IndexController extends GetxController {
  var selectPageIndex = 0.obs;
  void changeSelectPage(int index) {
    selectPageIndex.value = index;
  }
}
