import 'package:flutter/cupertino.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/exception/has_not_logged.dart';
import 'package:igzut/service/account_service.dart';
import 'package:igzut/service/course_service.dart';
import 'package:igzut/service/index.dart';
import 'package:igzut/service/login_service.dart';
import 'package:igzut/service/score_service.dart';
import 'package:igzut/tools/processor.dart';
import 'package:igzut/tools/show_toast.dart';
import 'package:igzut/tools/types.dart';

class GlobalState with ChangeNotifier {
  NetState _netState = NetState.loading;

  LoginState _loginState = LoginState.unlogin;

  Account? _accountInfo;

  final List<Score> _scoreList = [];

  final List<Course> _courseList = [];

  String _gradepoint = "----";

  String _credit = "--";

  CourseCount? _courseCount;

  ///网络状态
  NetState get netState => _netState;

  ///登陆状态
  LoginState get loginState => _loginState;

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

  void setNetState(NetState state) {
    _netState = state;
  }

  void setLoginuState(LoginState state) {
    _loginState = state;
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

  Future initFromDisk() async {
    var newAccountInfo = await AccountService().getAccountInfoRepo();
    var newScoreList = await ScoreService().getScoreList();
    var newCourseList = await CourseService().getAllCourse();
    update(newAccountInfo, newScoreList, newCourseList);
  }

  Future initFormNet(BuildContext context) async {
    LoginService loginService = LoginService();
    _netState = NetState.loading;
    notifyListeners();
    try {
      await loginService.tryLogin();
      var result = await Service.update();
      _netState = NetState.success;
      _loginState = LoginState.success;
      update(result.accountInfo, result.scoreList, result.courseList);
    } catch (e) {
      if (e is PasswordOrUsernameWrong) {
        _loginState = LoginState.failed;
        _netState = NetState.success;
      } else if (e is SchoolNetCannotAccess || e is LoginFailed) {
        if (context.mounted) context.showToast("校园网未连接");
        _loginState = LoginState.success;
        _netState = NetState.cannotAccess;
      } else if (e is NetNarrow) {
        if (context.mounted) context.showToast("网络拥挤，请稍后再试");
        _loginState = LoginState.success;
        _netState = NetState.success;
      } else if (e is HasNotLogged) {
        _loginState = LoginState.unlogin;
        _netState = NetState.loading;
      }
      notifyListeners();
    }
  }

  Future init(BuildContext context) async {
    initFromDisk();
    initFormNet(context);
  }
}
