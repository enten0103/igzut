import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/componets/course/course_card.dart';
import 'package:igzut/ui/componets/course/side_year_bar.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});

  ///计算学期信息
  List<String> extraTerms(List<Course> courseList) {
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
    return Consumer<GlobalState>(builder: (context, state, children) {
      ///join course和score
      List<FullCourse> courseList = state.courseList.map((e) {
        return FullCourse(
            course: e,
            score: state.scoreList.where((element) {
              return element.courseCode == e.courseCode;
            }).firstOrNull);
      }).toList();

      ///过滤
      filters.values.forEach(courseList.retainWhere);
      courseList.retainWhere(termFilter);

      ///获取课程属性和学期
      var natures =
          state.courseList.map((e) => e.courseNature).toSet().toList();
      var terms = widget.extraTerms(state.courseList);
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
    });
  }
}
