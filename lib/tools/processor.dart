import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/types.dart';

class Processor {
  static String calcGradePoint(List<Score> scoreList) {
    if (scoreList.isEmpty) return "--";
    var p1 = 0.0;
    var p2 = 0.0;
    for (var i = 0; i < scoreList.length; i++) {
      p1 += double.parse(scoreList[i].credit);
      p2 += double.parse(scoreList[i].gradePoint) *
          double.parse(scoreList[i].credit);
    }
    return (p2 / p1).toString().substring(0, 4);
  }

  static String calcCredit(List<Score> scoreList) {
    if (scoreList.isEmpty) return "__";
    try {
      return scoreList
          .fold(0.0, (v1, v2) {
            return v1 + double.parse(v2.credit);
          })
          .toInt()
          .toString();
    } catch (e) {
      return "__";
    }
  }

  static CourseCount calcCourseCount(
      List<Score> scoreList, List<Course> courseList) {
    var failed = 0;
    for (var i = 0; i < scoreList.length; i++) {
      var score = scoreList[i];
      if (score.gradePoint == "0.00") {
        failed++;
      }
    }
    return CourseCount(
        all: courseList.length,
        pass: courseList.length - failed,
        failed: failed);
  }
}
