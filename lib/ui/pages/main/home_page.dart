import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/componets/home/courses_info_card.dart';
import 'package:igzut/ui/componets/home/credit_earn_card.dart';
import 'package:igzut/ui/componets/home/grade_points_card.dart';
import 'package:igzut/ui/componets/home/other_action_card.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.gradePoint,
      this.accountInfo,
      required this.credit,
      this.courseCount});

  final String gradePoint;

  final Account? accountInfo;

  final String credit;

  final CourseCount? courseCount;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(children: [
            GradePointsCard(
              gradePoint: widget.gradePoint,
              college: widget.accountInfo?.college ?? "--学院",
              administrativeClass:
                  widget.accountInfo?.administrativeClass ?? "--",
            ),
            SizedBox(
              height: 10,
            ),
            CreditEarnCard(
                credit: widget.credit,
                name: widget.accountInfo?.name ?? "--",
                studentNumber: widget.accountInfo?.studentNumber ?? "--"),
            SizedBox(height: 10),
            CoursesInfoCard(
                all: widget.courseCount?.all ?? 0,
                pass: widget.courseCount?.pass ?? 0,
                failed: widget.courseCount?.failed ?? 0),
            OtherActionCard()
          ])),
    );
  }
}
