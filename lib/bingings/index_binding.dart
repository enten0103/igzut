import 'package:get/instance_manager.dart';
import 'package:igzut/controllers/course_data_controller.dart';
import 'package:igzut/controllers/exam_data_controller.dart';
import 'package:igzut/controllers/user_info_controller.dart';
import 'package:igzut/pages/course/controller.dart';
import 'package:igzut/pages/home/controller.dart';
import 'package:igzut/pages/index/controller.dart';
import 'package:igzut/pages/schedule/controller.dart';

class IndexBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CourseDataController());
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => CourseController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => (ScheduleController()));
    Get.lazyPut(() => (ExamDataController()));
  }
}
