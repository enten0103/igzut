import 'package:flutter/material.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/componets/course/course_card.dart';
import 'package:igzut/ui/componets/course/side_year_bar.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  @override
  State<CoursePage> createState() => _CourseState();
}

class _CourseState extends State<CoursePage> {
  Map<String, bool Function(FullCourse)> filters = {};
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(builder: (context, state, children) {
      List<FullCourse> courseList = state.courseList.map((e) {
        return FullCourse(
            course: e,
            score: state.scoreList.where((element) {
              return element.courseCode == e.courseCode;
            }).firstOrNull);
      }).toList();
      filters.values.forEach(courseList.retainWhere);
      return Row(children: [
        SideYearBar(
            onPresse: (text) {},
            natures:
                state.courseList.map((e) => e.courseNature).toSet().toList(),
            terms:
                state.courseList.map((e) => e.courseSelectionNumber).toList()),
        Expanded(
            child: ListView.builder(
                itemCount: state.courseList.length,
                itemBuilder: (context, index) {
                  return CourseCard(
                      course: courseList[index].course,
                      score: courseList[index].score);
                })),
        SizedBox(width: 10)
      ]);
    });
  }
}
