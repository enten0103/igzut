import 'package:flutter/material.dart';
import 'package:igzut/ui/componets/salomon_botton_bar.dart';
import 'package:igzut/ui/componets/wifi_connect_icon.dart';
import 'package:igzut/ui/pages/main/curriculum_page.dart';
import 'package:igzut/ui/pages/main/dash_board_page.dart';
import 'package:igzut/ui/pages/main/score_page.dart';

///仪表盘
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [DashBoardPage(), ScorePage(), CurriculumPage()];
  final List<String> titles = ["仪表盘", "成绩", "课表"];
  final List<IconData> icos = [
    Icons.dashboard,
    Icons.assessment,
    Icons.schedule
  ];
  int selectedPageIndex = 0;

  void setPageIndex(int newPageIndex) {
    setState(() {
      selectedPageIndex = newPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceBright,
        title: Text(titles[selectedPageIndex]),
        leading:
            IconButton(onPressed: () {}, icon: Icon(icos[selectedPageIndex])),
        actions: [WifiConnectIcon()],
      ),
      body: pages[selectedPageIndex],
      bottomNavigationBar: SalomonBottomBar(
          currentIndex: selectedPageIndex,
          onTap: setPageIndex,
          items: [
            SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("主页")),
            SalomonBottomBarItem(
                icon: Icon(Icons.assessment), title: Text("成绩")),
            SalomonBottomBarItem(icon: Icon(Icons.schedule), title: Text("课表"))
          ]),
    );
  }
}
