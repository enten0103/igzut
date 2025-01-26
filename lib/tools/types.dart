import 'package:gzu_zf_core/gzu_zf_core.dart';

enum NetState { cannotAccess, loading, success }

enum LoginState { unlogin, success, failed }

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

class CurriculumItem {
  String courseName;
  String teacherName;
  String time;
  List<MapEntry<String, String>> timeAndLocation;
  CurriculumItem(
      {required this.timeAndLocation,
      required this.teacherName,
      required this.courseName,
      required this.time});
}

class CourseFilterDrawerState {
  List<bool> passState = [true, true, true];
  List<bool> necessery = [true, true];
  List<bool> nature = [];
}
