import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/controllers/course_data_controller.dart';
import 'package:igzut/pages/schedule/componets/term_selector.dart';
import 'package:igzut/pages/schedule/controller.dart';
import 'package:igzut/pages/schedule/subpage/curriculum_page.dart';
import 'package:igzut/pages/schedule/subpage/examination_page.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheduleController = Get.find<ScheduleController>();
    final dataController = Get.find<CourseDataController>();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.schedule),
        title: Text("日程"),
        actions: [
          TermSelector(terms: dataController.terms),
          SizedBox(
              width: 100,
              child: TabBar(
                controller: scheduleController.tabController,
                tabs: scheduleController.tabs,
                isScrollable: false,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
              )),
        ],
      ),
      body: SafeArea(
        child: TabBarView(
          controller: scheduleController.tabController,
          children: [
            CurriculumPage(
                courses: dataController.courses, terms: dataController.terms),
            ExaminationPage() // Placeholder for schedule content
          ],
        ),
      ),
    );
  }
}
