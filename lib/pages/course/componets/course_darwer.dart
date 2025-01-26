import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/controllers/course_data_controller.dart';
import 'package:igzut/pages/course/controller.dart';

class CourseDarwer extends StatelessWidget {
  const CourseDarwer({super.key});

  @override
  Widget build(BuildContext context) {
    var courseController = Get.find<CourseController>();
    var dataController = Get.find<CourseDataController>();
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("通过状态", style: TextStyle(fontSize: 18)),
                Obx(() {
                  return Row(children: [
                    FilterChip(
                        label: Text("未考察"),
                        selected: courseController.passState[0],
                        onSelected: (args) =>
                            courseController.updatePassState(0)),
                    SizedBox(width: 10),
                    FilterChip(
                        label: Text("已通过"),
                        selected: courseController.passState[1],
                        onSelected: (args) =>
                            courseController.updatePassState(1)),
                    SizedBox(width: 10),
                    FilterChip(
                        label: Text("未通过"),
                        selected: courseController.passState[2],
                        onSelected: (args) =>
                            courseController.updatePassState(2)),
                  ]);
                }),
                SizedBox(height: 5),
                Text("选读必要性", style: TextStyle(fontSize: 18)),
                Obx(() {
                  return Row(children: [
                    FilterChip(
                        label: Text("必修"),
                        selected: courseController.necessary[0],
                        onSelected: (args) =>
                            courseController.updateNecessary(0)),
                    SizedBox(width: 10),
                    FilterChip(
                        label: Text("选修"),
                        selected: courseController.necessary[1],
                        onSelected: (args) =>
                            courseController.updateNecessary(1)),
                  ]);
                }),
                SizedBox(height: 5),
                Text("课程性质", style: TextStyle(fontSize: 18)),
                Obx(() {
                  return Wrap(
                    spacing: 10,
                    children: dataController.natures
                        .asMap()
                        .map((index, e) {
                          return MapEntry(
                              index,
                              FilterChip(
                                  selected:
                                      courseController.natureFilted[index],
                                  label: Text(e == "" ? "未知" : e),
                                  onSelected: (args) => courseController
                                      .updateNatureFiled(index)));
                        })
                        .values
                        .toList(),
                  );
                }),
              ],
            )));
  }
}
