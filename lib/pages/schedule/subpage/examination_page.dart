import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/pages/schedule/componets/exam_card.dart';
import 'package:igzut/pages/schedule/controller.dart';

class ExaminationPage extends StatelessWidget {
  const ExaminationPage({super.key, required this.exams, required this.terms});
  final List<Exam> exams;
  final List<String> terms;

  @override
  Widget build(BuildContext context) {
    var scheduleController = Get.find<ScheduleController>();
    return Obx(() {
      var items = exams
          .where((e) => e.courseSelectionNumber
              .contains(terms[scheduleController.selectTerm.value]))
          .toList();
      return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: items.isEmpty
              ? Center(
                  child: Text(
                  "本学期考试安排为空",
                  style: TextStyle(color: Colors.grey),
                ))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ExamCard(exam: items[index]);
                  }));
    });
  }
}
