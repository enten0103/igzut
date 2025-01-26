import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:igzut/route/route.dart';
import 'package:igzut/tools/types.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({super.key, required this.loginState});
  final LoginState loginState;
  @override
  Widget build(BuildContext context) {
    var colorTheme = Theme.of(context).colorScheme;
    Map<LoginState, Widget> userIcons = {
      LoginState.unlogin: Icon(
        Icons.person,
        color: colorTheme.onSurface,
      ),
      LoginState.failed: Icon(
        Icons.person_off,
        color: colorTheme.error,
      ),
      LoginState.success: Icon(Icons.check, color: colorTheme.primary),
    };
    return Card(
        elevation: 0,
        color: loginState == LoginState.unlogin ? null : Colors.transparent,
        shape: StadiumBorder(),
        child: InkWell(
            onTap: () {
              if (loginState == LoginState.unlogin) {
                Get.offNamed(RouteConfig.loginPage);
              }
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(children: [
                  if (loginState == LoginState.unlogin) Text("点击此处登陆"),
                  if (loginState == LoginState.failed)
                    Text(
                      "登陆失败",
                      style: TextStyle(color: colorTheme.error),
                    ),
                  SizedBox(width: 5),
                  userIcons[loginState]!
                ]))));
  }
}
