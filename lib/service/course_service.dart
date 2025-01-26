import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/course_repo.dart';

class CourseService {
  final CourseRepo _courseRepo = CourseRepo();
  Future<List<Course>> getAllCourse() {
    return _courseRepo.getAllSelectCourse();
  }

  Future<List<Course>> updateCourseList() async {
    var impl = Get.find<ZfImpl>();
    var courseList = await impl.querySelectCourses();
    _courseRepo.update(courseList);
    return courseList;
  }
}
