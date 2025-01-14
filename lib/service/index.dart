import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/account_info_repo.dart';
import 'package:igzut/repo/course_repo.dart';
import 'package:igzut/repo/score_repo.dart';
import 'package:igzut/tools/types.dart';

class Service {
  static late ZfImpl zfImpl;
  static final ScoreRepo _scoreRepo = ScoreRepo();
  static final AccountInfoRepo _accountInfoRepo = AccountInfoRepo();
  static final CourseRepo _courseRepo = CourseRepo();
  static Future<UpdateResult> update() async {
    var result = await Service.zfImpl.queryScore();
    var scoreRows = result['scoreRows'] as List<Score>;
    var accountInfo = result['accountInfo'] as Account;
    var courseList = await Service.zfImpl.queryAllCourse();
    _courseRepo.update(courseList);
    _scoreRepo.update(scoreRows);
    _accountInfoRepo.update(accountInfo);
    return UpdateResult(
        accountInfo: accountInfo, scoreList: scoreRows, courseList: courseList);
  }
}
