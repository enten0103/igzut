import 'package:flutter/cupertino.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/service/account_service.dart';
import 'package:igzut/service/course_service.dart';
import 'package:igzut/service/score_service.dart';
import 'package:igzut/tools/processor.dart';
import 'package:igzut/tools/types.dart';

class GlobalState with ChangeNotifier {
  NetState _netState = NetState.unLogin;

  Account? _accountInfo;

  final List<Score> _scoreList = [];

  final List<Course> _courseList = [];

  String _gradepoint = "----";

  String _credit = "--";

  CourseCount? _courseCount;

  NetState get netState => _netState;

  ///用户信息
  Account? get accountInfo => _accountInfo;

  ///成绩信息
  List<Score> get scoreList => _scoreList;

  ///选课信息
  List<Course> get courseList => _courseList;

  ///绩点
  String get gradePoint => _gradepoint;

  ///学分
  String get credit => _credit;

  CourseCount? get courseCount => _courseCount;

  void setLoginState(NetState state) {
    _netState = state;
    notifyListeners();
  }

  void update(Account? newAccountInfo, List<Score> newScoreList,
      List<Course> newCourseList) {
    _accountInfo = newAccountInfo;
    _scoreList.clear();
    _scoreList.addAll(newScoreList.reversed);
    _courseList.clear();
    _courseList.addAll(newCourseList.reversed);
    _gradepoint = Processor.calcGradePoint(newScoreList);
    _credit = Processor.calcCredit(newScoreList);
    _courseCount = Processor.calcCourseCount(newScoreList, newCourseList);
    notifyListeners();
  }

  Future init() async {
    var newAccountInfo = await AccountService().getAccountInfoRepo();
    var newScoreList = await ScoreService().getScoreList();
    var newCourseList = await CourseService().getAllCourse();
    update(newAccountInfo, newScoreList, newCourseList);
  }
}
