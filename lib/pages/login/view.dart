import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/route/route.dart';
import 'package:igzut/service/auth_service.dart';
import 'package:igzut/tools/side_banner.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    var username = "";
    var password = "";

    login() async {
      setState(() {
        isLoading = true;
      });
      FocusScope.of(context).unfocus();
      try {
        var service = AuthService();
        await service.login(username, password);
        Get.put(service, permanent: true);
        SideBanner.info("登录成功");
        Get.offNamed(RouteConfig.indexPage);
      } catch (e) {
        if (e is PasswordOrUsernameWrong) {
          SideBanner.info("账号或密码错误");
        } else if (e is DioException) {
          var error = e.error;
          if (error is SchoolNetCannotAccess) {
            SideBanner.info("无法连接至校园网");
          } else if (error is CannotParse) {
            SideBanner.info("未知错误");
          } else if (error is NetNarrow) {
            SideBanner.info("网络拥挤");
          }
        } else {
          SideBanner.info("未知错误！");
        }
      }
      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surfaceBright,
          centerTitle: true,
          title: Text("登录"),
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
                  onPressed: login,
                  child: Text('登录'),
                ),
              ],
            )),
          ),
          isLoading
              ? Center(
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
                ))
              : Container(),
        ]));
  }
}
