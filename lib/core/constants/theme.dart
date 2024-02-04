import 'package:danter/core/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSave {
  static const themm = "them";
  static final SharedPreferences shared = locator.get();

  static setTheme(bool them) {
    shared.setBool(themm, them);
  }

  static bool getTheme() {
    return shared.getBool(themm) ?? false;
  }
}
