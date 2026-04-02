import 'package:auction_clean_arch/core/constant/app_const.dart';
import 'package:auction_clean_arch/core/services/storage_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageService {
  FlutterSecureStorageService._();
  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static Future<void> setToken(String token) async {
    await _storage.write(key: AppConst.keyAccessToken, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: AppConst.keyAccessToken);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: AppConst.keyAccessToken);
  }
}
