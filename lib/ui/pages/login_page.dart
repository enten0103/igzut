import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/service/index.dart';
import 'package:igzut/service/login_service.dart';
import 'package:igzut/tools/event_bus.dart';
import 'package:igzut/tools/g_state.dart';
import 'package:igzut/tools/toaster.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  final String title = "登录";
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var toaster = getToaster();
  EventBus eventBus = EventBus();
  String username = "";
  String password = "";
  bool _isLoading = false;

  Future loginHandler(var context) async {
    final LoginService loginService = LoginService();
    setState(() {
      _isLoading = true;
    });
    try {
      var impl = await loginService.login(username, password);
      _isLoading = false;
      Service.zfImpl = impl;
      toaster("登陆成功");
      GState.hasLogin = true;
      GState.stamp = DateTime.timestamp().toString();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      if (e is CannotParse || e is LoginFailed) {
        toaster("未知错误！");
      } else if (e is PasswordOrUsernameWrong) {
        toaster("账号或密码错误！");
      } else if (e is NetNarrow) {
        toaster("三秒防刷，请稍候再试");
      } else if (e is SchoolNetCannotAccess) {
        toaster("未连接到校园网");
      }
      GState.hasLogin = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceBright,
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
                child: Column(
              children: [
                TextField(
                  onChanged: (text) => username = text,
                  decoration: InputDecoration(
                    labelText: '学号',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  onChanged: (text) => password = text,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '密码',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () => loginHandler(context),
                  child: Text('登录'),
                ),
              ],
            )),
          ),
          if (_isLoading)
            Center(
                child: SizedBox(
              width: 100,
              height: 100,
              child: Card(
                  child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("登录中")
                  ],
                ),
              )),
            )),
        ]));
  }
}
