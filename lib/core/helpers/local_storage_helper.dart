
import 'package:wassela_task_app/core/helpers/app_constants.dart';
import 'package:wassela_task_app/core/helpers/local_storage.dart';

class LocalStorageHelper {
  final LocalStorage localStorage;

  LocalStorageHelper({required this.localStorage});
  Future<void> saveToken(String token) async {
    await localStorage.writeSecureData(AppConstants.tokenKey, token);
  }

  Future<void> saveData(String key, String value) async {
    await localStorage.writeSecureData(key, value);
  }

  Future<String> getToken() async {
    return await localStorage.readSecureData(AppConstants.tokenKey);
  }

  Future<String> getData(String key) async {
    return await localStorage.readSecureData(key);
  }

  Future<void> saveLangCode(String value) async {
    await localStorage.writeSecureData(AppConstants.langCode, value.toString());
  }

  Future<String> getLangCode() async {
    return await localStorage.readSecureData(AppConstants.langCode);
  }

  Future<void> deleteSecureData(String key) async {
    await localStorage.deleteSecureData(key);
  }

  Future<void> deleteAllSecureData() async {
    await localStorage.deleteAllSecureData();
  }
}
