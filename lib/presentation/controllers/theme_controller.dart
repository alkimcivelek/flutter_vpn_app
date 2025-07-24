import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/theme_service.dart';

/// Controller for managing theme settings in the app
class ThemeController extends GetxController {
  final ThemeService _themeService = Get.find<ThemeService>();

  final RxBool _isDarkMode = false.obs;
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  bool get isDarkMode => _isDarkMode.value;
  ThemeMode get currentTheme => _themeMode.value;
  bool get isSystemTheme => _themeMode.value == ThemeMode.system;
  bool get isLightTheme => _themeMode.value == ThemeMode.light;

  List<ThemeModeOption> get themeModeOptions => [
    ThemeModeOption(
      mode: ThemeMode.system,
      title: 'System Default',
      subtitle: 'Follow system settings',
      icon: Icons.brightness_auto,
    ),
    ThemeModeOption(
      mode: ThemeMode.light,
      title: 'Light Mode',
      subtitle: 'Light theme always',
      icon: Icons.light_mode,
    ),
    ThemeModeOption(
      mode: ThemeMode.dark,
      title: 'Dark Mode',
      subtitle: 'Dark theme always',
      icon: Icons.dark_mode,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _loadCurrentTheme();
    _listenToSystemThemeChanges();
  }

  void _loadCurrentTheme() {
    _themeMode.value = _themeService.currentTheme;
    _updateDarkModeState();
  }

  void _updateDarkModeState() {
    switch (_themeMode.value) {
      case ThemeMode.dark:
        _isDarkMode.value = true;
        break;
      case ThemeMode.light:
        _isDarkMode.value = false;
        break;
      case ThemeMode.system:
        _isDarkMode.value = Get.isPlatformDarkMode;
        break;
    }
  }

  void _listenToSystemThemeChanges() {
    ever(_themeMode, (ThemeMode mode) {
      if (mode == ThemeMode.system) {
        _isDarkMode.value = Get.isPlatformDarkMode;
      }
    });
  }

  Future<void> toggleTheme() async {
    ThemeMode newTheme;

    if (_themeMode.value == ThemeMode.system) {
      newTheme = Get.isPlatformDarkMode ? ThemeMode.light : ThemeMode.dark;
    } else {
      newTheme = _isDarkMode.value ? ThemeMode.light : ThemeMode.dark;
    }

    await setTheme(newTheme);
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    try {
      await _themeService.switchTheme(themeMode);
      _themeMode.value = themeMode;
      _updateDarkModeState();

      Get.snackbar(
        'Theme Changed',
        'Theme has been updated to ${_getThemeName(themeMode)}',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to change theme: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> useSystemTheme() async {
    await setTheme(ThemeMode.system);
  }

  Future<void> useLightTheme() async {
    await setTheme(ThemeMode.light);
  }

  Future<void> useDarkTheme() async {
    await setTheme(ThemeMode.dark);
  }

  String _getThemeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default';
    }
  }

  String get currentThemeDescription {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Light Mode';
      case ThemeMode.dark:
        return 'Dark Mode';
      case ThemeMode.system:
        return 'System Default${Get.isPlatformDarkMode ? ' (Dark)' : ' (Light)'}';
    }
  }

  bool isThemeModeActive(ThemeMode mode) {
    return _themeMode.value == mode;
  }

  IconData get currentThemeIcon {
    if (_themeMode.value == ThemeMode.system) {
      return Icons.brightness_auto;
    }
    return _isDarkMode.value ? Icons.dark_mode : Icons.light_mode;
  }

  IconData get nextThemeIcon {
    if (_themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode ? Icons.light_mode : Icons.dark_mode;
    }
    return _isDarkMode.value ? Icons.light_mode : Icons.dark_mode;
  }
}

class ThemeModeOption {
  final ThemeMode mode;
  final String title;
  final String subtitle;
  final IconData icon;

  const ThemeModeOption({
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
