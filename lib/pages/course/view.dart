import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/controllers/course_data_controller.dart';
import 'package:igzut/pages/course/componets/course_card.dart';
import 'package:igzut/pages/course/componets/side_year_bar.dart';
import 'package:igzut/pages/course/controller.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    var courseDataController = Get.find<CourseDataController>();
    var courseController = Get.find<CourseController>();
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.fact_check),
          title: Text("课程"),
        ),
        body: Row(
          children: [
            SideYearBar(),
            Obx(() {
              var selectTerm = courseController.selectTerm;
              var terms = courseDataController.terms;
              var courseFilted = courseDataController.courseList.where((e) {
                if (selectTerm.value == 1) return true;
                return e.course.courseSelectionNumber
                    .contains(terms[selectTerm.value - 2]);
              }).toList();
              return Expanded(
                  child: ListView.builder(
                      itemCount: courseFilted.length,
                      itemBuilder: (context, index) {
                        return CourseCard(
                          course: courseFilted[index].course,
                          score: courseFilted[index].score,
                        );
                      }));
            }),
            SizedBox(width: 10)
          ],
        ));
  }
}
