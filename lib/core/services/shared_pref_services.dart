import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  final SharedPreferences _prefs;
  SharedPrefServices(this._prefs);
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  void deleteKey(String key) {
    _prefs.remove(key);
  }
}
