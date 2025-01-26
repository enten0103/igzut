import 'package:get/get.dart';
import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/account_info_repo.dart';

class AccountService {
  final AccountInfoRepo _accountInfoRepo = AccountInfoRepo();

  Future<Account?> getAccountInfo() async {
    return _accountInfoRepo.getAccountInfo();
  }

  Future<Account> updateAccountInfo() async {
    var impl = Get.find<ZfImpl>();
    var account = await impl.queryAccountInfo();
    _accountInfoRepo.update(account);
    return account;
  }
}
