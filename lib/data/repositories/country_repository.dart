import 'package:flutter_vpn_app/data/mock/mock_data.dart';
import 'package:flutter_vpn_app/data/models/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getAllCountries();
  Future<List<Country>> searchCountries(String query);
  Future<Country?> getCountryByName(String countryName);
}

class CountryRepositoryImpl implements CountryRepository {
  @override
  Future<List<Country>> getAllCountries() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return MockData.countries;
  }

  @override
  Future<List<Country>> searchCountries(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (query.isEmpty) {
      return MockData.countries;
    }

    final lowercaseQuery = query.toLowerCase();
    return MockData.countries.where((country) {
      return country.name.toLowerCase().contains(lowercaseQuery) ||
          (country.city != null &&
              country.city!.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }

  @override
  Future<Country?> getCountryByName(String countryName) async {
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      return MockData.countries.firstWhere(
        (country) => country.name.toLowerCase() == countryName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }
}
