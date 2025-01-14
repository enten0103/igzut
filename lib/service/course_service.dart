import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/course_repo.dart';

class CourseService {
  final CourseRepo courseRepo = CourseRepo();
  Future<List<Course>> getAllCourse() {
    return courseRepo.getAllSelectCourse();
  }
}
