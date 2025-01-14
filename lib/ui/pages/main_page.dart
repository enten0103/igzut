import 'package:flutter/material.dart';
import 'package:igzut/ui/componets/salomon_botton_bar.dart';
import 'package:igzut/ui/componets/wifi_connect_icon.dart';
import 'package:igzut/ui/pages/main/course_page.dart';
import 'package:igzut/ui/pages/main/curriculum_page.dart';
import 'package:igzut/ui/pages/main/dash_board_page.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

///仪表盘
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> pages = [DashBoardPage(), CoursePage(), CurriculumPage()];
  final List<String> titles = ["主页", "课程", "日程"];
  final List<IconData> icos = [
    Icons.dashboard,
    Icons.fact_check,
    Icons.schedule
  ];
  int selectedPageIndex = 0;

  void setPageIndex(int newPageIndex) {
    setState(() {
      selectedPageIndex = newPageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) Provider.of<GlobalState>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(titles[selectedPageIndex]),
        leading:
            IconButton(onPressed: () {}, icon: Icon(icos[selectedPageIndex])),
        actions: [WifiConnectIcon()],
      ),
      body: pages[selectedPageIndex],
      bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          selectedItemColor: Theme.of(context).colorScheme.onSurface,
          currentIndex: selectedPageIndex,
          onTap: setPageIndex,
          items: [
            SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("主页")),
            SalomonBottomBarItem(
                icon: Icon(Icons.fact_check), title: Text("课程")),
            SalomonBottomBarItem(icon: Icon(Icons.schedule), title: Text("日程"))
          ]),
      drawer: Drawer(
        child: ElevatedButton(
            onPressed: () => Navigator.pop(context, 1), child: Text("button")),
      ),
    );
  }
}
