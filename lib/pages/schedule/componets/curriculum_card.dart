import 'package:flutter/material.dart';
import 'package:igzut/tools/types.dart';

class CurriculumCard extends StatelessWidget {
  const CurriculumCard({super.key, required this.curriculumItem});

  final CurriculumItem curriculumItem;

  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    var classInfo =
        curriculumItem.time.substring(3, curriculumItem.time.indexOf("节"));

    return Card(
        child: IntrinsicHeight(
            child: Row(children: [
      ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
          child: ColoredBox(
              color: colorTheme.primaryContainer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ...classInfo.split(',').map((e) {
                    return Text(e, style: TextStyle(fontFamily: "NotoSerif"));
                  }),
                  Text("节"),
                ],
              ))),
      SizedBox(width: 10),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(curriculumItem.courseName, style: TextStyle(fontSize: 18)),
          Text(curriculumItem.teacherName),
          Wrap(children: [
            ...curriculumItem.timeAndLocation.map((e) {
              return Card(
                  elevation: 0,
                  color: colorTheme.secondary,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
                      child: Text(
                        "${e.key}  ${e.value}",
                        style: TextStyle(color: colorTheme.onSecondary),
                      )));
            })
          ])
        ],
      ))
    ])));
  }
}
