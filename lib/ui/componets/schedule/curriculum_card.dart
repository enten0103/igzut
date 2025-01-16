import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    return Text(e, style: GoogleFonts.notoSerif());
                  }),
                  Text("节", style: GoogleFonts.notoSerif()),
                ],
              ))),
      SizedBox(width: 10),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(curriculumItem.courseName,
              style: GoogleFonts.notoSerif(fontSize: 18)),
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
                        style: GoogleFonts.notoSerif(
                            color: colorTheme.onSecondary),
                      )));
            })
          ])
        ],
      ))
    ])));
  }
}
