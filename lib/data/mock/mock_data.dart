import 'package:flutter_vpn_app/core/constants/asset_constants.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/data/models/country.dart';

class MockData {
  static final List<Country> countries = [
    const Country(
      id: "1",
      name: 'Italy',
      flag: AssetConstants.italyFlag,
      city: 'Milan',
      locationCount: 4,
      strength: 75,
    ),
    const Country(
      id: "2",
      name: 'Netherlands',
      flag: AssetConstants.netherlandsFlag,
      city: 'Amsterdam',
      locationCount: 12,
      strength: 85,
    ),
    const Country(
      id: "3",
      name: 'Germany',
      flag: AssetConstants.germanyFlag,
      city: 'Berlin',
      locationCount: 10,
      strength: 90,
    ),
    const Country(
      id: "4",
      name: 'Germany',
      flag: AssetConstants.germanyFlag,
      city: 'Berlin',
      locationCount: 12,
      strength: 95,
    ),
  ];

  static ConnectionStats get initialConnectionStats => ConnectionStats(
    id: '0',
    downloadSpeed: 0,
    uploadSpeed: 0,
    connectedTime: Duration.zero,
    connectedCountry: null,
    status: ConnectionStatus.disconnected,
  );

  static ConnectionStats get connectedStats => ConnectionStats(
    id: '0',
    downloadSpeed: 527,
    uploadSpeed: 49,
    connectedTime: const Duration(hours: 2, minutes: 41, seconds: 52),
    connectedCountry: countries[1],
    connectionStartTime: DateTime.now().subtract(
      const Duration(hours: 2, minutes: 41, seconds: 52),
    ),
    status: ConnectionStatus.connected,
    dataUsed: 1250,
  );

  static List<int> get downloadSpeedVariations => [
    520,
    535,
    510,
    545,
    527,
    540,
    515,
    530,
    525,
    538,
  ];

  static List<int> get uploadSpeedVariations => [
    45,
    52,
    48,
    51,
    49,
    47,
    53,
    46,
    50,
    49,
  ];
}
