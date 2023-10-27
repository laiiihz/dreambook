import 'package:shared_preferences/shared_preferences.dart';

class KV {
  static late SharedPreferences _instance;
  static Future ensureInitialized() async {
    _instance = await SharedPreferences.getInstance();
  }

  static bool get darkMode => _instance.getBool('darkMode') ?? false;

  static set darkMode(bool state) => _instance.setBool('darkMode', state);
}
