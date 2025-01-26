import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/pages/schedule/controller.dart';

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key, required this.courses, required this.terms});
  final List<Course> courses;
  final List<String> terms;
  @override
  Widget build(BuildContext context) {
    var scheduleController = Get.find<ScheduleController>();
    return Obx(() {
      var items = ScheduleController.extraItems(courses
          .where((e) => e.courseSelectionNumber
              .contains(terms[scheduleController.selectTerm.value]))
          .toList());
      return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: items.isEmpty
              ? Center(
                  child: Text(
                  "本学期课表为空",
                  style: TextStyle(color: Colors.grey),
                ))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return items[index];
                  }));
    });
  }
}
