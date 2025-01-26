import 'package:get/state_manager.dart';

class CourseController extends GetxController {
  ///side_bar_state
  var selectTerm = 1.obs;

  ///course_darwer_state
  RxList<bool> natureFilted = <bool>[].obs;
  RxList<bool> necessary = <bool>[true, true].obs;
  RxList<bool> passState = <bool>[true, true, true].obs;

  void setSelectTerm(int newTerm) {
    selectTerm.value = newTerm;
  }

  updatePassState(int index) {
    passState[index] = !passState[index];
  }

  updateNecessary(int index) {
    necessary[index] = !necessary[index];
  }

  updateNatureFiled(int index) {
    natureFilted[index] = !natureFilted[index];
  }

  @override
  void onInit() {
    natureFilted.addAll(List.filled(100, true));
    super.onInit();
  }
}
