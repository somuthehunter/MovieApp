import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  /// The singleton instance of SecureStorage.
  static final LocalStorage instance = LocalStorage._internal();

  static late SharedPreferences _sp;

  LocalStorage._internal();
  factory LocalStorage() => instance;

  static Future<void> create() async {
   _sp = await SharedPreferences.getInstance();
  }

  /// Stores the specified data securely.
  ///
  /// [key] The unique identifier for the data.
  /// [value] The value to be stored.
  Future<String> setData({required String key, required String value}) async {
    await _sp.setString(key, value);
    return value;
  }

  /// Retrieves the data associated with the specified key.
  ///
  /// [key] The unique identifier for the data.
  String? getData({required String key}) {
    return _sp.getString(key);
  }

  /// Removes the data associated with the specified key.
  ///
  /// [key] The unique identifier for the data to be removed.
  Future<bool> removeData({required String key}) {
    return _sp.remove(key);
  }
}
