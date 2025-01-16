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

  static List<String> extraTerms(List<Course> courseList) {
    var terms = courseList.map((e) => e.courseSelectionNumber).toList();
    Set<String> resultSet = {};
    RegExp regExp = RegExp(r"\((\d{4}-\d{4}-\d)\)");
    for (String item in terms) {
      Match? match = regExp.firstMatch(item);
      if (match != null) {
        resultSet.add(match.group(1)!);
      }
    }
    return resultSet.toList();
  }

  static List<CurriculumItem> extraCurriculumItem(List<Course> courseList) {
    List<CurriculumItem> result = [];

    for (var i = 0; i < courseList.length; i++) {
      var course = courseList[i];
      if (course.classTime == "" ||
          course.classTime == "e;" ||
          course.classTime == "e") {
        break;
      }
      Map<String, List<MapEntry<String, String>>> timeMapDur = {};
      var classTimeList = course.classTime.split(";");
      for (var j = 0; j < classTimeList.length; j++) {
        var classTime = classTimeList[j];
        if (classTime == "" || classTime == "e;") break;
        var preTime = classTime.substring(0, classTime.indexOf("节") + 1);
        var subTime = classTime.substring(
            classTime.indexOf("{") + 2, classTime.indexOf("}"));
        var classLocation = course.classLocation.split(";")[j];
        if (timeMapDur[preTime] == null) {
          timeMapDur[preTime] = [];
        }
        timeMapDur[preTime]!.add(MapEntry(subTime, classLocation));
      }
      for (var j = 0; j < timeMapDur.keys.length; j++) {
        result.add(CurriculumItem(
            timeAndLocation: timeMapDur[timeMapDur.keys.toList()[j]]!,
            teacherName: course.teacherName,
            courseName: course.courseName,
            time: timeMapDur.keys.toList()[j]));
      }
    }

    return result;
  }
}
