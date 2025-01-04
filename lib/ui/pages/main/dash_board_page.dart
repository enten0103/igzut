import 'package:flutter/material.dart';
import 'package:igzut/service/account_service.dart';
import 'package:igzut/service/score_service.dart';
import 'package:igzut/tools/g_state.dart';
import 'package:igzut/ui/componets/home/courses_info_card.dart';
import 'package:igzut/ui/componets/home/credit_earn_card.dart';
import 'package:igzut/ui/componets/home/grade_points_card.dart';
import 'package:igzut/tools/event_bus.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoardPage> {
  ///state
  String gradePoint = "--";
  String college = "--学院";
  String administrativeClass = "----";

  ///service
  ScoreService scoreService = ScoreService();
  AccountService accountService = AccountService();

  ///init
  accountInit(args) async {
    var accountInfo = await accountService.getAccountInfoRepo(GState.stamp);
    if (accountInfo == null) return;
    setState(() {
      college = accountInfo.college;
      administrativeClass = accountInfo.administrativeClass;
    });
  }

  scoreInit(args) async {
    var scoreList = await scoreService.getScoreList(GState.stamp);
    if (scoreList.isEmpty) return;
    var p1 = 0.0;
    var p2 = 0.0;
    for (var i = 0; i < scoreList.length; i++) {
      p1 += double.parse(scoreList[i].credit);
      p2 += double.parse(scoreList[i].gradePoint) *
          double.parse(scoreList[i].credit);
    }
    setState(() {
      gradePoint = (p2 / p1).toString().substring(0, 4);
    });
  }

  init(args) {
    scoreInit(null);
    accountInit(null);
  }

  @override
  void initState() {
    super.initState();
    init(null);
    EventBus().on("login", init);
    EventBus().on("scoreUpdate", scoreInit);
    EventBus().on("accountInfoUpdate", accountInit);
  }

  @override
  void deactivate() {
    super.deactivate();
    EventBus().off("login", init);
    EventBus().off("scoreUpdate", scoreInit);
    EventBus().off("accountInfoUpdate", accountInit);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 350.0,
      child: Column(
        children: <Widget>[
          GradePointsCard(
            gradePoint: gradePoint,
            college: college,
            administrativeClass: administrativeClass,
          ),
          CreditEarnCard(),
          CoursesInfoCard(),
        ],
      ),
    ));
  }
}
