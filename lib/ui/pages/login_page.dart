import 'package:flutter/material.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/service/index.dart';
import 'package:igzut/tools/show_toast.dart';
import 'package:igzut/service/login_service.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/state/index.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  final String title = "登录";
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool _isLoading = false;

  Future loginHandler() async {
    final LoginService loginService = LoginService();
    var globalState = Provider.of<GlobalState>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    try {
      var impl = await loginService.login(username, password);
      Service.zfImpl = impl;
      var result = await Service.update();
      globalState.update(
          result.accountInfo, result.scoreList, result.courseList);
      setState(() {
        _isLoading = false;
      });
      if (mounted) context.showToast("登陆成功");
      globalState.setLoginState(NetState.logged);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      var message = "";
      if (e is CannotParse || e is LoginFailed) {
        message = "登陆失败";
      } else if (e is PasswordOrUsernameWrong) {
        message = "账号或密码错误";
      } else if (e is NetNarrow) {
        message = "网络拥挤，请稍后再试";
      } else if (e is SchoolNetCannotAccess) {
        message = "无法连接至校园网";
      }
      if (mounted) context.showToast(message);
      globalState.setLoginState(NetState.unLogin);
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
                  onPressed: loginHandler,
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
