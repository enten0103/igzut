import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/account_info_repo.dart';
import 'package:igzut/service/index.dart';
import 'package:igzut/tools/event_bus.dart';

class AccountService {
  final AccountInfoRepo _accountInfoRepo = AccountInfoRepo();
  final EventBus _eventBus = EventBus();
  static String _stamp = "";
  Future<AccountInfo?> getAccountInfoRepo(String stamp) async {
    var accountInfo = _accountInfoRepo.getAccountInfo();
    if (stamp != _stamp) {
      _stamp = stamp;
      Service.zfImpl.queryScore().then((result) async {
        await _accountInfoRepo.update(result['accountInfo'] as AccountInfo);
        _eventBus.emit("accountInfoUpdate");
      });
    }
    return accountInfo;
  }
}
