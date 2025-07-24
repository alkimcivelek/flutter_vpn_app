import 'package:flutter/material.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/data/repositories/country_repository.dart';
import 'package:get/get.dart';

class CountrySelectionViewModel extends GetxController {
  final CountryRepository _countryRepository;

  CountrySelectionViewModel({required CountryRepository countryRepository})
    : _countryRepository = countryRepository;

  final textController = TextEditingController();

  final RxList<Country> _countries = <Country>[].obs;
  final RxList<Country> _filteredCountries = <Country>[].obs;
  final RxString _searchQuery = ''.obs;
  final RxBool _isLoading = false.obs;

  List<Country> get countries => _countries;
  List<Country> get filteredCountries => _filteredCountries;
  String get searchQuery => _searchQuery.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    _isLoading.value = true;
    try {
      final countries = await _countryRepository.getAllCountries();
      _countries.value = countries;
      _filteredCountries.value = countries;
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

  Future<void> searchCountries(String query) async {
    _searchQuery.value = query;

    if (query.isEmpty) {
      _filteredCountries.value = _countries;
      update();
      return;
    }

    try {
      final filtered = await _countryRepository.searchCountries(query);
      _filteredCountries.value = filtered;
      update();
    } catch (e) {
      Get.snackbar(
        'Search Error',
        'Failed to search countries: $e',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void clearSearch() {
    _searchQuery.value = '';
    _filteredCountries.value = _countries;
    textController.clear();
    update();
  }

  void selectCountry(Country country) {
    Get.back(result: country);
  }
}
