import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  var storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? '';
    debugPrint('Data read from secure storage: $value');

    return value;
  }


  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAllSecureData() async {
    debugPrint('All Data Wiped ');

    await storage.deleteAll();
  }

  Future<bool> containKey(String key) async {
    bool haskey = await storage.containsKey(key: key) ? true : false;
    return haskey;
  }

  IOSOptions _getIOSOptions() => const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock, synchronizable: true);

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true

          // sharedPreferencesName: 'Test2',
          // preferencesKeyPrefix: 'Test'
          );

  Future<void> sharedPrefsInit() async {
    //   _prefs = await SharedPreferences.getInstance();
    storage = FlutterSecureStorage(
        aOptions: _getAndroidOptions(), iOptions: _getIOSOptions());
  }
}
