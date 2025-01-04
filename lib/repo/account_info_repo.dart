import 'package:shared_preferences/shared_preferences.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';

class AccountInfoRepo {
  final String accountInfoKey = "account_info_key";
  Future update(AccountInfo accountInfo) async {
    final preb = await SharedPreferences.getInstance();
    await preb.setString(accountInfoKey, accountInfo.toJsonString());
  }

  Future<AccountInfo?> getAccountInfo() async {
    final preb = await SharedPreferences.getInstance();
    var jsonStr = preb.getString(accountInfoKey);
    if (jsonStr == null) return null;
    return AccountInfo.fromJson(jsonStr);
  }
}
