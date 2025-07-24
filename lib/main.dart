import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vpn_app/app/app.dart';
import 'package:flutter_vpn_app/core/services/theme_service.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  await _initializeServices();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const VPNApp());
}

Future<void> _initializeServices() async {
  // Initialize Theme Service
  await Get.putAsync(() async {
    final service = ThemeService();
    await service.onInit();
    return service;
  });
}
