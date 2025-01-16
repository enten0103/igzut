import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course, this.score});
  final Course course;
  final Score? score;

  @override
  Widget build(BuildContext context) {
    var classTime = course.classTime.split(";");
    classTime.removeLast();
    var teachers = course.teacherName.split("/");
    return Card(
        elevation: 0,
        child: Padding(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                course.courseName,
                style: GoogleFonts.notoSerif(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("教师 "),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: teachers.map((e) {
                      return Text(e);
                    }).toList(),
                  )
                ],
              ),
              if (course.classLocation != "")
                Row(
                  children: [Text("地点 ${course.classLocation.split(";")[0]}")],
                ),
              if (course.classTime != "e;")
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("时间 "),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: classTime.map((e) {
                        return Text(e);
                      }).toList(),
                    )
                  ],
                ),
              if (score != null) SizedBox(height: 10),
              if (score != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("成绩 ${score?.score}"),
                    Text("绩点 ${score?.gradePoint}"),
                    Text("学分 ${score?.credit}")
                  ],
                ),
            ])));
  }
}
