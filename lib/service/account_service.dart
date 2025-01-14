import 'package:gzu_zf_core/gzu_zf_core.dart';
import 'package:igzut/repo/account_info_repo.dart';

class AccountService {
  final AccountInfoRepo _accountInfoRepo = AccountInfoRepo();
  Future<Account?> getAccountInfoRepo() async {
    return _accountInfoRepo.getAccountInfo();
  }
}
