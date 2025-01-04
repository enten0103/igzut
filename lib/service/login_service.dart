import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/service/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  Future tryLogin() async {
    final pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var password = pref.getString('password');
    if (username == null || password == null) return;
    var impl = ZfImpl.getImpl(username, password);
    await impl.login();
    Service.zfImpl = impl;
  }

  Future<ZfImpl> login(String username, String password) async {
    var impl = ZfImpl.getImpl(username, password);
    await impl.login();
    final pref = await SharedPreferences.getInstance();
    await pref.setString("username", username);
    await pref.setString("password", password);
    return impl;
  }
}
