import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/service/login_service.dart';
import 'package:igzut/tools/event_bus.dart';
import 'package:igzut/tools/g_state.dart';
import 'package:igzut/tools/toaster.dart';
import 'package:igzut/ui/pages/login_page.dart';

class WifiConnectIcon extends StatefulWidget {
  const WifiConnectIcon({super.key});

  @override
  State<WifiConnectIcon> createState() => _WifiConnectIconState();
}

class _WifiConnectIconState extends State<WifiConnectIcon> {
  var icsIndex = GState.hasLogin ? 0 : 2;
  LoginService loginService = LoginService();
  var toaster = getToaster();
  EventBus eventBus = EventBus();

  final List<Widget> ics = [
    Icon(Icons.link_off, color: Colors.red),
    SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
    Icon(Icons.wifi_tethering, color: Colors.green),
  ];

  void login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future init() async {
    setState(() {
      icsIndex = 1;
    });
    try {
      await loginService.tryLogin();
      GState.hasLogin = true;
      GState.stamp = DateTime.timestamp().toString();
      eventBus.emit("login");
      if (mounted) {
        setState(() {
          icsIndex = 2;
        });
      }
    } catch (e) {
      if (e is PasswordOrUsernameWrong) {
        login();
      } else if (e is SchoolNetCannotAccess) {
        toaster("未连接到校园网");
      }
      GState.hasLogin = false;
      if (mounted) {
        setState(() {
          icsIndex = 0;
        });
      }
    }
  }

  Future refresh() async {
    setState(() {
      icsIndex = 1;
    });
    init();
  }

  void logoutHandler(args) {
    setState(() {
      icsIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
    eventBus.on('logout', logoutHandler);
  }

  @override
  void deactivate() {
    super.deactivate();
    eventBus.off('logout', logoutHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child:
            InkWell(onTap: refresh, onLongPress: login, child: ics[icsIndex]));
  }
}
