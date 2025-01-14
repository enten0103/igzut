import 'package:gzu_zf_core/gzu_zf_core.dart';

enum NetState { unLogin, cannotAccess, loading, logged }

class UpdateResult {
  Account? accountInfo;
  final List<Score> scoreList;
  final List<Course> courseList;

  UpdateResult(
      {required this.accountInfo,
      required this.scoreList,
      required this.courseList});
}

class CourseCount {
  final int all;
  final int pass;
  final int failed;
  CourseCount({required this.all, required this.pass, required this.failed});
}

class FullCourse {
  Course course;
  Score? score;
  FullCourse({required this.course, required this.score});
}
