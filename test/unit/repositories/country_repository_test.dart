import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/data/repositories/country_repository.dart';

void main() {
  group('CountryRepository Tests', () {
    late CountryRepository repository;

    setUp(() {
      repository = CountryRepositoryImpl();
    });

    test('should return list of countries', () async {
      final countries = await repository.getAllCountries();

      expect(countries, isNotEmpty);
      expect(countries.length, greaterThan(5));
      expect(countries.first, isA<Country>());
    });

    test('should search countries by name', () async {
      final results = await repository.searchCountries('Netherlands');

      expect(results, isNotEmpty);
      expect(
        results.any(
          (country) => country.name.toLowerCase().contains('netherlands'),
        ),
        true,
      );
    });

    test('should search countries by city', () async {
      final results = await repository.searchCountries('Amsterdam');

      expect(results, isNotEmpty);
      expect(
        results.any(
          (country) =>
              country.city?.toLowerCase().contains('amsterdam') ?? false,
        ),
        true,
      );
    });

    test('should return all countries for empty search', () async {
      final results = await repository.searchCountries('');
      final allCountries = await repository.getAllCountries();

      expect(results.length, allCountries.length);
    });

    test('should find country by country code', () async {
      final country = await repository.getCountryByName('Netherlands');

      expect(country, isNotNull);
      expect(country!.name, 'Netherlands');
    });

    test('should return null for invalid country code', () async {
      final country = await repository.getCountryByName('X');

      expect(country, isNull);
    });

    test('should be case insensitive for country code search', () async {
      final country1 = await repository.getCountryByName('Germany');
      final country2 = await repository.getCountryByName('Netherlands');

      expect(country1, equals(country2));
    });
  });
}
