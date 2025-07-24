import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vpn_app/core/constants/asset_constants.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/data/repositories/connection_repository.dart';
import 'package:flutter_vpn_app/data/repositories/country_repository.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([CountryRepository, ConnectionRepository])
void main() {
  group('HomeController Tests', () {
    late HomeViewModel homeController;
    late MockCountryRepository mockCountryRepository;
    late MockConnectionRepository mockConnectionRepository;

    const testCountries = [
      Country(
        id: "1",
        name: 'Italy',
        flag: AssetConstants.italyFlag,
        city: 'Milan',
        locationCount: 4,
        strength: 75,
      ),
      Country(
        id: "2",
        name: 'Netherlands',
        flag: AssetConstants.netherlandsFlag,
        city: 'Amsterdam',
        locationCount: 12,
        strength: 85,
      ),
      Country(
        id: "3",
        name: 'Germany',
        flag: AssetConstants.germanyFlag,
        city: 'Berlin',
        locationCount: 10,
        strength: 90,
      ),
      Country(
        id: "4",
        name: 'Germany',
        flag: AssetConstants.germanyFlag,
        city: 'Berlin',
        locationCount: 12,
        strength: 95,
      ),
    ];

    const testStats = ConnectionStats(
      id: '0',
      downloadSpeed: 0,
      uploadSpeed: 0,
      connectedTime: Duration.zero,
      connectedCountry: null,
      status: ConnectionStatus.disconnected,
    );

    setUp(() async {
      Get.reset();
      mockCountryRepository = MockCountryRepository();
      mockConnectionRepository = MockConnectionRepository();

      when(
        mockCountryRepository.getAllCountries(),
      ).thenAnswer((_) async => testCountries);
      when(
        mockConnectionRepository.getCurrentStats(),
      ).thenAnswer((_) async => testStats);
      when(
        mockConnectionRepository.getConnectionStats(),
      ).thenAnswer((_) => Stream.value(testStats));

      homeController = HomeViewModel(
        countryRepository: mockCountryRepository,
        connectionRepository: mockConnectionRepository,
      );
    });

    tearDown(() async {
      Get.reset();
    });

    test('should initialize with correct data', () async {
      homeController.onInit();

      expect(homeController.countries.length, testCountries.length);

      expect(homeController.isLoading, false);
      verify(mockCountryRepository.getAllCountries()).called(1);
    });

    test('should connect to country successfully', () async {
      final connectedStats = ConnectionStats(
        id: '1',
        downloadSpeed: 500,
        uploadSpeed: 50,
        connectedTime: Duration.zero,
        connectedCountry: testCountries[0],
        status: ConnectionStatus.connected,
      );

      when(
        mockConnectionRepository.connect(testCountries[0]),
      ).thenAnswer((_) async => connectedStats);

      await homeController.connectToCountry(testCountries[0]);

      verify(mockConnectionRepository.connect(testCountries[0])).called(1);
    });

    test('should disconnect successfully', () async {
      const disconnectedStats = ConnectionStats(
        id: '1',
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        connectedCountry: null,
        status: ConnectionStatus.disconnected,
      );

      when(
        mockConnectionRepository.disconnect(),
      ).thenAnswer((_) async => (disconnectedStats, null));

      await homeController.disconnect();

      verify(mockConnectionRepository.disconnect()).called(1);
    });

    test('should update search query', () {
      const query = 'Netherlands';
      homeController.updateSearchQuery(query);

      expect(homeController.searchQuery, query);
    });

    test('should clear search query', () {
      homeController.updateSearchQuery('test');
      homeController.clearSearch();

      expect(homeController.searchQuery, '');
    });

    test('should refresh data', () async {
      await homeController.refreshData();

      verify(mockCountryRepository.getAllCountries()).called(1);
    });

    test('should handle connection status correctly', () {
      expect(homeController.isConnected, false);
      expect(homeController.isDisconnected, true);
    });
  });
}

class MockCountryRepository extends Mock implements CountryRepository {
  @override
  Future<List<Country>> getAllCountries() => super.noSuchMethod(
    Invocation.method(#getAllCountries, []),
    returnValue: Future.value(<Country>[]),
  );

  @override
  Future<List<Country>> searchCountries(String query) => super.noSuchMethod(
    Invocation.method(#searchCountries, [query]),
    returnValue: Future.value(<Country>[]),
  );
}

class MockConnectionRepository extends Mock implements ConnectionRepository {
  @override
  Future<ConnectionStats> connect(Country country) => super.noSuchMethod(
    Invocation.method(#connect, [country]),
    returnValue: Future.value(
      const ConnectionStats(
        id: '1',
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        status: ConnectionStatus.disconnected,
      ),
    ),
  );

  @override
  Future<(ConnectionStats, Country?)> disconnect() => super.noSuchMethod(
    Invocation.method(#disconnect, []),
    returnValue: Future.value((
      const ConnectionStats(
        id: '1',
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        status: ConnectionStatus.disconnected,
      ),
      null,
    )),
  );

  @override
  Stream<ConnectionStats> getConnectionStats() => super.noSuchMethod(
    Invocation.method(#getConnectionStats, []),
    returnValue: Stream.value(
      const ConnectionStats(
        id: '1',
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        status: ConnectionStatus.disconnected,
      ),
    ),
  );

  @override
  Future<ConnectionStats> getCurrentStats() => super.noSuchMethod(
    Invocation.method(#getCurrentStats, []),
    returnValue: Future.value(
      const ConnectionStats(
        id: '1',
        downloadSpeed: 0,
        uploadSpeed: 0,
        connectedTime: Duration.zero,
        status: ConnectionStatus.disconnected,
      ),
    ),
  );
}
