import 'package:flutter/material.dart';
import 'package:igzut/ui/componets/home/courses_info_card.dart';
import 'package:igzut/ui/componets/home/credit_earn_card.dart';
import 'package:igzut/ui/componets/home/grade_points_card.dart';
import 'package:igzut/ui/componets/home/other_action_card.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Consumer<GlobalState>(builder: (context, state, child) {
          return Column(children: [
            GradePointsCard(
              gradePoint: state.gradePoint,
              college: state.accountInfo?.college ?? "--学院",
              administrativeClass:
                  state.accountInfo?.administrativeClass ?? "--",
            ),
            SizedBox(
              height: 10,
            ),
            CreditEarnCard(
                credit: state.credit,
                name: state.accountInfo?.name ?? "--",
                studentNumber: state.accountInfo?.studentNumber ?? "--"),
            SizedBox(height: 10),
            CoursesInfoCard(
                all: state.courseCount?.all ?? 0,
                pass: state.courseCount?.pass ?? 0,
                failed: state.courseCount?.failed ?? 0),
            OtherActionCard()
          ]);
        }),
      ),
    );
  }
}
