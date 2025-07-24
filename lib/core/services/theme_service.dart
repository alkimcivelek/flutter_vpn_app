import 'package:flutter/material.dart';
import 'package:flutter_vpn_app/core/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends GetxService {
  static ThemeService get to => Get.find();

  late SharedPreferences _prefs;

  @override
  Future<void> onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    _loadThemeFromPrefs();
  }

  ThemeMode _getThemeFromPrefs() {
    final themeString = _prefs.getString(AppConstants.themeKey);
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  void _loadThemeFromPrefs() {
    final themeMode = _getThemeFromPrefs();
    Get.changeThemeMode(themeMode);
  }

  Future<void> switchTheme(ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    await _saveThemeToPrefs(themeMode);
  }

  Future<void> _saveThemeToPrefs(ThemeMode themeMode) async {
    String themeString;
    switch (themeMode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    await _prefs.setString(AppConstants.themeKey, themeString);
  }

  bool get isDarkMode {
    final themeMode = _getThemeFromPrefs();
    if (themeMode == ThemeMode.system) {
      return Get.isPlatformDarkMode;
    }
    return themeMode == ThemeMode.dark;
  }

  bool get isLightMode => !isDarkMode;

  ThemeMode get currentTheme => _getThemeFromPrefs();
}
