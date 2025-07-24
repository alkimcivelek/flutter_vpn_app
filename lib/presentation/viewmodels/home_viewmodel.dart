import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/core/utils/logger.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/data/repositories/connection_repository.dart';
import 'package:flutter_vpn_app/data/repositories/country_repository.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  final CountryRepository _countryRepository;
  final ConnectionRepository _connectionRepository;

  HomeViewModel({
    required CountryRepository countryRepository,
    required ConnectionRepository connectionRepository,
  }) : _countryRepository = countryRepository,
       _connectionRepository = connectionRepository;

  final RxList<Country> _countries = <Country>[].obs;
  final Rx<ConnectionStats> _connectionStats = ConnectionStats(
    id: '0',
    downloadSpeed: 0,
    uploadSpeed: 0,
    connectedTime: Duration.zero,
    status: ConnectionStatus.disconnected,
  ).obs;
  final _lastConnectionCountry = Rx<Country?>(null);
  final RxBool _isLoading = false.obs;
  final RxBool _isConnecting = false.obs;
  final RxString _searchQuery = ''.obs;
  final RxInt selectedIndex = 0.obs;

  List<Country> get countries => _countries;
  ConnectionStats get connectionStats => _connectionStats.value;
  bool get isLoading => _isLoading.value;
  Country? get lastConnectionCountry => _lastConnectionCountry.value;
  bool get isConnecting => _isConnecting.value;
  bool get isConnected => connectionStats.status == ConnectionStatus.connected;
  bool get isDisconnected =>
      connectionStats.status == ConnectionStatus.disconnected;
  String get searchQuery => _searchQuery.value;

  StreamSubscription<ConnectionStats>? _statsSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _subscribeToConnectionStats();
  }

  @override
  void onClose() {
    _statsSubscription?.cancel();
    super.onClose();
  }

  Future<void> _initializeData() async {
    _isLoading.value = true;
    try {
      final allCountries = await _countryRepository.getAllCountries();

      _countries.value = allCountries;

      final currentStats = await _connectionRepository.getCurrentStats();
      _connectionStats.value = currentStats;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load countries: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      _isLoading.value = false;
      update();
    }
  }

  void _subscribeToConnectionStats() {
    _statsSubscription = _connectionRepository.getConnectionStats().listen(
      (stats) {
        _connectionStats.value = stats;
        _isConnecting.value =
            stats.status == ConnectionStatus.connecting ||
            stats.status == ConnectionStatus.disconnecting;
      },
      onError: (error) {
        Get.snackbar(
          'Connection Error',
          error.toString(),
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }

  Future<void> connectToCountry(Country country) async {
    if (_isConnecting.value) return;

    try {
      _isConnecting.value = true;
      await _connectionRepository.connect(country);

      Get.snackbar(
        'Connected',
        'Successfully connected to ${country.displayName}',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Connection Failed',
        'Failed to connect to ${country.name}: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      update();
    }
  }

  Future<void> disconnect() async {
    if (_isConnecting.value) return;

    try {
      _isConnecting.value = true;
      var result = await _connectionRepository.disconnect();
      _lastConnectionCountry.value = result.$2;

      Get.snackbar(
        'Disconnected',
        'VPN connection has been terminated',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Disconnection Failed',
        'Failed to disconnect: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      update();
    }
  }

  Future<void> toggleConnection([Country? country]) async {
    if (isConnected) {
      await disconnect();
    } else if (country != null) {
      await connectToCountry(country);
    }
    update();
  }

  void clearSearch() {
    _searchQuery.value = '';
  }

  Future<void> refreshData() async {
    await _initializeData();
  }

  Future<void> handleDisconnectTap() async {
    try {
      if (isConnected) {
        Logger.info('User initiated disconnect from disconnect view');

        await disconnect();
        await Future.delayed(const Duration(milliseconds: 500));
        Get.back();
      }
    } catch (e, stackTrace) {
      Logger.error('Failed to disconnect from disconnect view', e, stackTrace);

      Get.snackbar(
        'Error',
        'Failed to disconnect: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorConstants.errorRed,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 3),
      );
    } finally {
      update();
    }
  }

  void updateSearchQuery(String query) {
    _searchQuery.value = query;
    update();
  }
}
