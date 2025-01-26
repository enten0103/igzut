import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/pages/schedule/componets/curriculum_card.dart';
import 'package:igzut/tools/types.dart';

class ScheduleController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var selectTerm = 0.obs;

  final tabs = [
    const Tab(text: '课表'),
    const Tab(text: '考试'),
  ];

  setSelectTerm(int index) {
    selectTerm.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  static String extraTermString(String term) {
    var text = "";
    var splitTerm = term.split("-");
    if (splitTerm[2] == "1") {
      text = "${splitTerm[0]}秋";
    } else {
      text = "${splitTerm[1]}春";
    }
    return text;
  }

  static List<CurriculumItem> extraCurriculumItem(List<Course> courseList) {
    List<CurriculumItem> result = [];

    for (var i = 0; i < courseList.length; i++) {
      var course = courseList[i];
      if (course.classTime == "") {
        continue;
      }

      Map<String, List<MapEntry<String, String>>> timeMapDur = {};
      var classTimeList = course.classTime.split(";");
      for (var j = 0; j < classTimeList.length; j++) {
        var classTime = classTimeList[j];
        if (classTime == "") break;
        var preTime = classTime.substring(0, classTime.indexOf("节") + 1);
        var subTime = classTime.substring(
            classTime.indexOf("{") + 2, classTime.indexOf("}"));
        var classLocation = course.classLocation.split(";")[j];
        if (timeMapDur[preTime] == null) {
          timeMapDur[preTime] = [];
        }
        timeMapDur[preTime]!.add(MapEntry(subTime, classLocation));
      }
      for (var j = 0; j < timeMapDur.keys.length; j++) {
        result.add(CurriculumItem(
            timeAndLocation: timeMapDur[timeMapDur.keys.toList()[j]]!,
            teacherName: course.teacherName,
            courseName: course.courseName,
            time: timeMapDur.keys.toList()[j]));
      }
    }

    return result;
  }

  static List<Widget> extraItems(List<Course> courseList) {
    final numberToWeek = {
      0: "周一",
      1: "周二",
      2: "周三",
      3: "周四",
      4: "周五",
      5: "周六",
      6: "周日"
    };
    ({int weekday, int section}) parseTime(String time) {
      final weekdays = {
        "周一": 1,
        "周二": 2,
        "周三": 3,
        "周四": 4,
        "周五": 5,
        "周六": 6,
        "周日": 7
      };

      final weekday = weekdays.keys.firstWhere((key) => time.contains(key));
      final weekdayNumber = weekdays[weekday]!;

      final sectionMatch = RegExp(r'第(\d+)').firstMatch(time);
      final section = int.parse(sectionMatch?.group(1) ?? '0');

      return (weekday: weekdayNumber, section: section);
    }

    var result = extraCurriculumItem(courseList);
    result.sort((a, b) {
      var aTime = parseTime(a.time);
      var bTime = parseTime(b.time);
      if (aTime.weekday != bTime.weekday) {
        return aTime.weekday.compareTo(bTime.weekday);
      }
      return aTime.section.compareTo(bTime.section);
    });
    final List<Widget> items = [];

    int currentWeekday = -1;

    for (var i = 0; i < result.length; i++) {
      var curriculumItem = result[i];
      var timeInfo = parseTime(curriculumItem.time);
      if (timeInfo.weekday != currentWeekday) {
        currentWeekday = timeInfo.weekday;

        // 添加分隔符
        items.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              numberToWeek[currentWeekday - 1]!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }
      // 添加课程卡片
      items.add(CurriculumCard(curriculumItem: curriculumItem));
    }
    return items;
  }
}
