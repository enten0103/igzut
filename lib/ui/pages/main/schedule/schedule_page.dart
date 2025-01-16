import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/event_bus.dart';
import 'package:igzut/ui/pages/main/schedule/curriculum_page.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage(
      {super.key, required this.courseList, required this.terms});

  final List<Course> courseList;

  final List<String> terms;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var selectTerm = 0;
  final PageController _pageController = PageController();

  void onPageChanegEvent(args) {
    if (mounted) {
      _pageController.animateToPage(args,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void onTermChangeEvent(args) {
    if (mounted) {
      setState(() {
        selectTerm = args;
      });
    }
  }

  EventBus eventBus = EventBus();
  @override
  void initState() {
    super.initState();
    eventBus.on("schedule_page_change_bar", onPageChanegEvent);
    eventBus.on("schedule_term_change_bar", onTermChangeEvent);
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.off("schedule_page_change_bar", onPageChanegEvent);
    eventBus.off("schedule_term_change_bar", onTermChangeEvent);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: _pageController,
        onPageChanged: (index) {
          eventBus.emit("schedule_page_change", index);
        },
        children: [
          CurriculumPage(
              courseList: widget.courseList.where((e) {
            return e.courseSelectionNumber.contains(widget.terms[selectTerm]);
          }).toList()),
          Text("暂未实现"),
        ]);
  }
}
