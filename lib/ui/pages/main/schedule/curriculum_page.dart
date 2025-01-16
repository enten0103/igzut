import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/processor.dart';
import 'package:igzut/ui/componets/schedule/curriculum_card.dart';

class CurriculumPage extends StatelessWidget {
  const CurriculumPage({super.key, required this.courseList});

  final List<Course> courseList;

  @override
  Widget build(BuildContext context) {
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

    var result = Processor.extraCurriculumItem(courseList);
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
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return items[index];
            }));
  }
}
