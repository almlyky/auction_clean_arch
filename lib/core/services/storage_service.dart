abstract class StorageService {
  Future<void> setData(String key, String value);
  Future<String?> getData(String key);
  Future<void> deleteData(String key);
}
