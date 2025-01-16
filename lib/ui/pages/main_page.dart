import 'package:flutter/material.dart';
import 'package:igzut/tools/processor.dart';
import 'package:igzut/ui/bar/igzut_bar.dart';
import 'package:igzut/ui/componets/salomon_botton_bar.dart';
import 'package:igzut/ui/pages/main/course_page.dart';
import 'package:igzut/ui/pages/main/home_page.dart';
import 'package:igzut/ui/pages/main/schedule/schedule_page.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

///仪表盘
class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
      if (mounted) {
        Provider.of<GlobalState>(context, listen: false).init(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (context, state, child) {
        return Scaffold(
          appBar: IgzutBar(
              terms: Processor.extraTerms(state.courseList.where((e) {
                return e.classTime != "" &&
                    e.classTime != "e;" &&
                    e.classTime != "e";
              }).toList()),
              selectPage: selectedPageIndex,
              netState: state.netState,
              loginState: state.loginState),
          body: _buildBody(state),
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
            selectedItemColor: Theme.of(context).colorScheme.onSurface,
            currentIndex: selectedPageIndex,
            onTap: setPageIndex,
            items: [
              SalomonBottomBarItem(icon: Icon(Icons.home), title: Text("主页")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.fact_check), title: Text("课程")),
              SalomonBottomBarItem(
                  icon: Icon(Icons.schedule), title: Text("日程"))
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(GlobalState state) {
    var cl = state.courseList.where((e) {
      return e.classTime != "" && e.classTime != "e;" && e.classTime != "e";
    }).toList();
    switch (selectedPageIndex) {
      case 1:
        return CoursePage(
            courseList: state.courseList, scoreList: state.scoreList);
      case 2:
        return SchedulePage(
          terms: Processor.extraTerms(cl),
          courseList: cl,
        );
      default:
        return HomePage(
            gradePoint: state.gradePoint,
            credit: state.credit,
            courseCount: state.courseCount,
            accountInfo: state.accountInfo);
    }
  }
}
