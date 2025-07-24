import 'package:flutter/material.dart';
import 'package:flutter_vpn_app/core/utils/logger.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:get/get.dart';

class DisconnectViewmodel extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _pulseController;

  final HomeViewModel homeController = Get.find<HomeViewModel>();

  AnimationController get backgroundController => _backgroundController;
  AnimationController get pulseController => _pulseController;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
  }

  @override
  void onClose() {
    _disposeAnimations();
    super.onClose();
  }

  void _initializeAnimations() {
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    Logger.info('DisconnectController animations initialized');
  }

  void _disposeAnimations() {
    _backgroundController.dispose();
    _pulseController.dispose();
    Logger.info('DisconnectController animations disposed');
  }
}
