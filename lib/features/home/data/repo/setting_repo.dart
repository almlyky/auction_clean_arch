import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/services/shared_pref_services.dart';

class SettingRepo {
  final SharedPrefServices _sharedPrefServices;
  SettingRepo(this._sharedPrefServices);
  Future<void> saveTheme(bool isDarkMode) async {
    await _sharedPrefServices.setBool(AppConst.isDarkMode, isDarkMode);
  }

  bool? getTheme() {
    return _sharedPrefServices.getBool(AppConst.isDarkMode);
  }
}
