import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/processor.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/componets/course/course_card.dart';
import 'package:igzut/ui/componets/course/side_year_bar.dart';

class CoursePage extends StatefulWidget {
  const CoursePage(
      {super.key, required this.courseList, required this.scoreList});

  final List<Course> courseList;
  final List<Score> scoreList;

  @override
  State<CoursePage> createState() => _CourseState();
}

class _CourseState extends State<CoursePage> {
  ///过滤器
  Map<String, bool Function(FullCourse)> filters = {};

  ///学期选择
  bool Function(FullCourse) termFilter = (args) {
    return true;
  };

  @override
  Widget build(BuildContext context) {
    ///join course和score
    List<FullCourse> courseList = widget.courseList.map((e) {
      return FullCourse(
          course: e,
          score: widget.scoreList.where((element) {
            return element.courseCode == e.courseCode;
          }).firstOrNull);
    }).toList();

    ///过滤
    filters.values.forEach(courseList.retainWhere);
    courseList.retainWhere(termFilter);

    ///获取课程属性和学期
    var natures = widget.courseList.map((e) => e.courseNature).toSet().toList();
    var terms = Processor.extraTerms(widget.courseList);
    return Row(children: [
      SideYearBar(
          onSelectTermChange: (args) {
            if (args == 1) {
              setState(() {
                termFilter = (fc) => true;
              });
            } else {
              setState(() {
                termFilter = (fc) {
                  return fc.course.courseSelectionNumber
                      .contains(terms[args - 2]);
                };
              });
            }
          },
          natures: natures,
          terms: terms),
      Expanded(
          child: ListView.builder(
              itemCount: courseList.length,
              itemBuilder: (context, index) {
                return CourseCard(
                    course: courseList[index].course,
                    score: courseList[index].score);
              })),
      SizedBox(width: 10)
    ]);
  }
}
