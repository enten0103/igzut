import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:igzut/controllers/course_data_controller.dart';
import 'package:igzut/pages/course/componets/course_darwer.dart';
import 'package:igzut/pages/course/controller.dart';

class SideYearBar extends StatelessWidget {
  const SideYearBar({super.key});

  @override
  Widget build(BuildContext context) {
    var courseController = Get.find<CourseController>();
    var dataController = Get.find<CourseDataController>();
    return Obx(() {
      ///有一个抽象bug,如果不事先提取数据，那么就不会触发更新
      ///以任何方式读取数据均可避免
      var terms = dataController.terms;
      var selectTerm = courseController.selectTerm.value;
      return Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
              width: 80,
              child: ListView.builder(
                  itemCount: terms.length + 2,
                  itemBuilder: (context, index) {
                    var resultText = "";
                    if (index == 0) {
                      return IconButton(
                          onPressed: () async {
                            await showModalBottomSheet<String>(
                              context: context,
                              builder: (context) {
                                return CourseDarwer();
                              },
                            );
                          },
                          icon: Icon(Icons.filter_alt_outlined));
                    } else if (index == 1) {
                      resultText = "全部";
                    } else {
                      var result = terms[index - 2].split("-");
                      if (result[2] == "1") {
                        resultText = "${result[0]}-秋";
                      } else {
                        resultText = "${result[1]}-春";
                      }
                    }

                    return ElevatedButton(
                        onPressed: () {
                          if (index != 0) {
                            courseController.setSelectTerm(index);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: selectTerm == index
                                ? Theme.of(context).colorScheme.primary
                                : Color.fromARGB(0, 0, 0, 0),
                            shape: StadiumBorder(),
                            padding: EdgeInsets.all(0),
                            elevation: 0),
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Center(
                              child: Text(
                            resultText,
                            style: TextStyle(
                                fontFamily: "NotoSerif",
                                fontSize: 16,
                                color: selectTerm == index
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Colors.black),
                          )),
                        ));
                  })));
    });
  }
}
