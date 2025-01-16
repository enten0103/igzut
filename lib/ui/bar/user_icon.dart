import 'package:flutter/material.dart';
import 'package:igzut/tools/types.dart';
import 'package:igzut/ui/pages/login_page.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({super.key, required this.loginState, required this.showTip});
  final LoginState loginState;
  final bool showTip;
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
        color: showTip ? null : Colors.transparent,
        shape: StadiumBorder(),
        child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(children: [
                  if (showTip) Text("点击此处登陆"),
                  userIcons[loginState]!
                ]))));
  }
}
