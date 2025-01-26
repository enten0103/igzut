import 'dart:async';

import 'package:get/instance_manager.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/tools/types.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Completer<LoginState> _loginCompleter = Completer();

  final Completer<NetState> _netCompleter = Completer();

  LoginState? _hasLogin;
  NetState? _netState;

  Future<LoginState> get hasLogin async {
    if (_hasLogin != null) return _hasLogin!;
    return _loginCompleter.future;
  }

  Future<NetState> get netState async {
    if (_netState != null) return _netState!;
    return _netCompleter.future;
  }

  Future tryLogin() async {
    final pref = await SharedPreferences.getInstance();
    var username = pref.getString('username');
    var password = pref.getString('password');
    if (username == null || password == null) {
      _loginCompleter.complete(LoginState.unlogin);
      _netCompleter.complete(NetState.success);
    } else {
      try {
        var impl = ZfImpl.getImpl(username, password);
        await impl.login();
        _loginCompleter.complete(LoginState.success);
        _netCompleter.complete(NetState.success);
        Get.put(impl);
      } catch (e) {
        _loginCompleter.complete(LoginState.failed);
        if (e is PasswordOrUsernameWrong) {
          _netCompleter.complete(NetState.success);
        } else if (e is DioException) {
          var error = e.error;
          if (error is SchoolNetCannotAccess || error is NetNarrow) {
            _netCompleter.complete(NetState.cannotAccess);
          } else if (error is CannotParse) {
            _netCompleter.complete(NetState.success);
          }
        }
      }
    }
  }

  Future login(String username, String password) async {
    var impl = ZfImpl.getImpl(username, password);
    await impl.login();
    Get.put(impl, permanent: true);
    final pref = await SharedPreferences.getInstance();
    await pref.setString("username", username);
    await pref.setString("password", password);
    _hasLogin = LoginState.success;
    _loginCompleter.complete(LoginState.success);
    _netState = NetState.success;
    _netCompleter.complete(NetState.success);
  }
}
