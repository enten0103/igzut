import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:igzut/tools/event_bus.dart';

class ScheduleBar extends StatefulWidget {
  const ScheduleBar({
    super.key,
    required this.terms,
  });

  final List<String> terms;

  @override
  State<StatefulWidget> createState() => _ScheduleBarState();
}

class _ScheduleBarState extends State<ScheduleBar> {
  EventBus eventBus = EventBus();

  var selectTerm = 0;
  var selectPage = 0;

  void onSchedulePageChange(page) {
    if (mounted) {
      setState(() {
        selectPage = page;
      });
    }
  }

  @override
  void initState() {
    eventBus.on("schedule_page_change", onSchedulePageChange);
    super.initState();
  }

  @override
  void dispose() {
    eventBus.off("schedule_page_change", onSchedulePageChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> termTexts = widget.terms.map((e) {
      var result = e.split("-");
      if (result[2] == "1") {
        return "${result[0]}-秋";
      } else {
        return "${result[1]}-春";
      }
    }).toList();
    var colorTheme = Theme.of(context).colorScheme;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(children: [
        PopupMenuButton(
            onSelected: (args) {
              setState(() {
                selectTerm = termTexts.indexOf(args);
                eventBus.emit("schedule_term_change_bar", selectTerm);
              });
            },
            child: Text(
              termTexts[selectTerm],
              style: GoogleFonts.notoSerif(fontSize: 16),
            ),
            itemBuilder: (context) {
              return termTexts.map((e) {
                return PopupMenuItem<String>(value: e, child: Text(e));
              }).toList();
            }),
        SizedBox(width: 15),
        InkWell(
            onTap: () {
              setState(() {
                selectPage = 0;
                eventBus.emit("schedule_page_change_bar", 0);
              });
            },
            child: Text(
              "课表",
              style: GoogleFonts.notoSerif(
                  fontSize: 16,
                  color: selectPage == 0 ? colorTheme.primaryFixedDim : null,
                  decoration: selectPage == 0 ? TextDecoration.underline : null,
                  decorationColor: colorTheme.primary,
                  decorationThickness: 4),
            )),
        SizedBox(width: 10),
        InkWell(
            onTap: () {
              setState(() {
                selectPage = 1;
                eventBus.emit("schedule_page_change_bar", 1);
              });
            },
            child: Text("考试",
                style: GoogleFonts.notoSerif(
                    fontSize: 16,
                    color: selectPage == 1 ? colorTheme.primaryFixedDim : null,
                    decoration:
                        selectPage == 1 ? TextDecoration.underline : null,
                    decorationColor: colorTheme.primary,
                    decorationThickness: 4))),
      ])
    ]);
  }
}
