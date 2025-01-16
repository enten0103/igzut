import 'package:flutter/material.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/bar/net_icon.dart';
import 'package:igzut/ui/bar/user_icon.dart';
import 'package:igzut/ui/componets/schedule/schedule_bar.dart';

class IgzutBar extends StatefulWidget implements PreferredSizeWidget {
  const IgzutBar(
      {super.key,
      required this.selectPage,
      required this.netState,
      required this.loginState,
      required this.terms});

  final int selectPage;

  final NetState netState;

  final LoginState loginState;

  final List<String> terms;

  @override
  State<IgzutBar> createState() => _IgzutBarState();
  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // 设置 AppBar 的高度
}

class _IgzutBarState extends State<IgzutBar> {
  final List<String> titles = ["主页", "课程", "日程"];
  final List<IconData> leadingIcons = [
    Icons.dashboard,
    Icons.fact_check,
    Icons.schedule
  ];
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titles[widget.selectPage]),
      leading: Icon(leadingIcons[widget.selectPage]),
      actions: [
        if (widget.selectPage == 2)
          ScheduleBar(
            terms: widget.terms,
          ),
        UserIcon(
          loginState: widget.loginState,
          showTip: widget.loginState == LoginState.unlogin &&
              widget.netState == NetState.success &&
              widget.selectPage == 0,
        ),
        NetIcon(
          netState: widget.netState,
        )
      ],
    );
  }
}
