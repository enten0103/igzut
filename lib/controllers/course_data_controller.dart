import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/controllers/common_controller.dart';
import 'package:igzut/service/course_service.dart';
import 'package:igzut/service/score_service.dart';
import 'package:igzut/tools/show_toast.dart';
import 'package:igzut/tools/types.dart';

class CourseDataController extends CommonController {
  final RxList<FullCourse> courseList = <FullCourse>[].obs;

  final RxList<Course> courses = <Course>[].obs;

  final RxList<Score> scores = <Score>[].obs;

  RxList<String> terms = <String>[].obs;

  RxList<String> natures = <String>[].obs;

  ///课程通过情况
  CourseCount courseCount = CourseCount(all: 0, pass: 0, failed: 0);

  var gradePoint = "--".obs;
  var credit = "--".obs;

  @override
  void onInit() async {
    var scoreService = ScoreService();
    var courseService = CourseService();
    var scoreList = (await scoreService.getScoreList()).reversed.toList();
    var courseList = (await courseService.getAllCourse()).reversed.toList();
    scores.addAll(scoreList);
    courses.addAll(courseList);

    List<FullCourse> fullCourseList = courseList
        .map((e) {
          return FullCourse(
              course: e,
              score: scoreList.where((element) {
                return element.courseCode == e.courseCode;
              }).firstOrNull);
        })
        .toList()
        .toList();
    this.courseList.addAll(fullCourseList);
    gradePoint.value = calcGradePoint(scoreList);
    credit.value = calcCredit(scoreList);
    courseCount = calcCourseCount(scoreList, courseList);
    terms.addAll(extraTerms(courseList));
    natures.addAll(extraNatures(courseList));
    super.onInit();
  }

  static List<String> extraNatures(List<Course> courseList) =>
      courseList.map((e) => e.courseNature).toSet().toList();

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

  @override
  void onLogin() async {
    var scoreService = ScoreService();
    var courseService = CourseService();
    Get.overlayContext?.showToast("数据更新中...");
    var scoreList = (await scoreService.updateScoreList()).reversed.toList();
    var courseList = (await courseService.updateCourseList()).reversed.toList();
    Get.overlayContext?.showToast("更新成功");
    scores.clear();
    scores.addAll(scoreList);
    courses.clear();
    courses.addAll(courseList);

    List<FullCourse> fullCourseList = courseList
        .map((e) {
          return FullCourse(
              course: e,
              score: scoreList.where((element) {
                return element.courseCode == e.courseCode;
              }).firstOrNull);
        })
        .toList()
        .toList();
    this.courseList.clear();
    this.courseList.addAll(fullCourseList);
    gradePoint.value = calcGradePoint(scoreList);
    credit.value = calcCredit(scoreList);
    courseCount = calcCourseCount(scoreList, courseList);
    terms.clear();
    terms.addAll(extraTerms(courseList));
    natures.clear();
    natures.addAll(extraNatures(courseList));
  }
}
