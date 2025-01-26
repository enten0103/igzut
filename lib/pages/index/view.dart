import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/pages/about/view.dart';
import 'package:igzut/pages/course/view.dart';
import 'package:igzut/pages/home/view.dart';
import 'package:igzut/pages/index/componets/salomon_botton_bar.dart';
import 'package:igzut/pages/index/controller.dart';
import 'package:igzut/pages/schedule/view.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    var indexcontroller = Get.find<IndexController>();
    var pages = [HomePage(), CoursePage(), SchedulePage(), AboutPage()];
    return Obx(() => Scaffold(
          body: pages[indexcontroller.selectPageIndex.value],
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            selectedItemColor: Theme.of(context).colorScheme.onSurface,
            currentIndex: indexcontroller.selectPageIndex.value,
            onTap: indexcontroller.changeSelectPage,
            items: [
              SalomonBottomBarItem(
                  icon: Icon(Icons.home_outlined), title: Text("主页")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.fact_check_outlined), title: Text("课程")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.schedule), title: Text("日程")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.error_outline_outlined), title: Text("关于"))
            ],
          ),
        ));
  }
}
