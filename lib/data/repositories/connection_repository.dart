import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_vpn_app/core/constants/app_constants.dart';
import 'package:flutter_vpn_app/data/mock/mock_data.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/data/models/country.dart';

abstract class ConnectionRepository {
  Future<ConnectionStats> connect(Country country);
  Future<(ConnectionStats, Country?)> disconnect();
  Stream<ConnectionStats> getConnectionStats();
  Future<ConnectionStats> getCurrentStats();
}

class ConnectionRepositoryImpl implements ConnectionRepository {
  ConnectionStats _currentStats = MockData.initialConnectionStats;
  final StreamController<ConnectionStats> _statsController =
      StreamController<ConnectionStats>.broadcast();
  Timer? _updateTimer;
  DateTime? _connectionStartTime;
  final Random _random = Random();
  ConnectionRepositoryImpl() {
    if (kDebugMode) {
      print('Repository initialized');
    }
    _statsController.add(_currentStats);
  }

  @override
  Future<ConnectionStats> connect(Country country) async {
    _currentStats = _currentStats.copyWith(
      id: country.id,
      status: ConnectionStatus.connecting,
      isConnecting: true,
    );
    _statsController.add(_currentStats);
    if (kDebugMode) {
      print('Stream event: $_currentStats');
    }

    await Future.delayed(const Duration(seconds: 2));

    _connectionStartTime = DateTime.now();
    _currentStats = ConnectionStats(
      id: country.id,
      downloadSpeed: _generateRandomSpeed(true),
      uploadSpeed: _generateRandomSpeed(false),
      connectedTime: Duration.zero,
      connectedCountry: country,
      connectionStartTime: _connectionStartTime,
      status: ConnectionStatus.connected,
      isConnecting: false,
      dataUsed: 0,
    );

    _startStatsUpdater();
    _statsController.add(_currentStats);
    if (kDebugMode) {
      print('Stream event: $_currentStats');
    }

    return _currentStats;
  }

  @override
  Future<(ConnectionStats, Country?)> disconnect() async {
    _currentStats = _currentStats.copyWith(
      id: _currentStats.connectedCountry?.id ?? '0',
      status: ConnectionStatus.disconnecting,
    );
    _statsController.add(_currentStats);
    if (kDebugMode) {
      print('Stream event: $_currentStats');
    }

    await Future.delayed(const Duration(seconds: 1));

    var lastConnectedCountry = _currentStats.connectedCountry;

    _stopStatsUpdater();
    _currentStats = MockData.initialConnectionStats;

    _statsController.add(_currentStats);
    if (kDebugMode) {
      print('Stream event: $_currentStats');
    }

    return (_currentStats, lastConnectedCountry);
  }

  @override
  Stream<ConnectionStats> getConnectionStats() {
    return _statsController.stream;
  }

  @override
  Future<ConnectionStats> getCurrentStats() async {
    return _currentStats;
  }

  void _startStatsUpdater() {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(AppConstants.statsUpdateInterval, (timer) {
      if (_currentStats.status == ConnectionStatus.connected &&
          _connectionStartTime != null) {
        final connectedDuration = DateTime.now().difference(
          _connectionStartTime!,
        );
        final dataIncrement = _random.nextInt(5) + 1; // 1-5 MB per second

        _currentStats = _currentStats.copyWith(
          id: _currentStats.connectedCountry?.id ?? '0',
          downloadSpeed: _generateRandomSpeed(true),
          uploadSpeed: _generateRandomSpeed(false),
          connectedTime: connectedDuration,
          dataUsed: _currentStats.dataUsed + dataIncrement,
        );

        _statsController.add(_currentStats);
      }
    });
  }

  void _stopStatsUpdater() {
    _updateTimer?.cancel();
    _updateTimer = null;
    _connectionStartTime = null;
  }

  int _generateRandomSpeed(bool isDownload) {
    final baseSpeed = isDownload ? 500 : 45;
    final variation = isDownload ? 50 : 10;

    return baseSpeed + _random.nextInt(variation * 2) - variation;
  }

  void dispose() {
    _updateTimer?.cancel();
    _statsController.close();
  }
}
