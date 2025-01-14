import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/exception/has_not_logged.dart';
import 'package:igzut/service/index.dart';
import 'package:igzut/service/login_service.dart';
import 'package:igzut/tools/show_toast.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/pages/login_page.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

class WifiConnectIcon extends StatefulWidget {
  const WifiConnectIcon({super.key});

  @override
  State<WifiConnectIcon> createState() => _WifiConnectIconState();
}

class _WifiConnectIconState extends State<WifiConnectIcon> {
  LoginService loginService = LoginService();

  final Map<NetState, Widget> ics = {
    NetState.unLogin: Icon(Icons.account_circle, color: Colors.blue),
    NetState.cannotAccess: Icon(Icons.link_off, color: Colors.red),
    NetState.loading:
        SizedBox(width: 16, height: 16, child: CircularProgressIndicator()),
    NetState.logged: Icon(Icons.wifi_tethering, color: Colors.green)
  };

  void login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future init() async {
    var globalState = Provider.of<GlobalState>(context, listen: false);
    globalState.setLoginState(NetState.loading);
    try {
      await loginService.tryLogin();
      var result = await Service.update();
      globalState.update(
          result.accountInfo, result.scoreList, result.courseList);
      globalState.setLoginState(NetState.logged);
    } catch (e) {
      if (e is PasswordOrUsernameWrong) {
        login();
      } else if (e is SchoolNetCannotAccess || e is LoginFailed) {
        if (mounted) context.showToast("校园网未连接");
        globalState.setLoginState(NetState.cannotAccess);
      } else if (e is NetNarrow) {
        if (mounted) context.showToast("网络拥挤，请稍后再试");
        globalState.setLoginState(NetState.unLogin);
      } else if (e is HasNotLogged) {
        globalState.setLoginState(NetState.unLogin);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(init);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: InkWell(
            onTap: init,
            onLongPress: login,
            child: Selector<GlobalState, NetState>(
              selector: (context, state) => state.netState,
              builder: (context, netState, child) {
                return ics[netState]!;
              },
            )));
  }
}
