import 'package:flutter_vpn_app/core/services/theme_service.dart';
import 'package:flutter_vpn_app/data/repositories/connection_repository.dart';
import 'package:flutter_vpn_app/data/repositories/country_repository.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/country_selection_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/disconnect_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/main_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ThemeService>(ThemeService(), permanent: true);

    Get.lazyPut<CountryRepository>(() => CountryRepositoryImpl(), fenix: true);
    Get.lazyPut<ConnectionRepository>(
      () => ConnectionRepositoryImpl(),
      fenix: true,
    );
    Get.lazyPut<MainViewModel>(() => MainViewModel(), fenix: true);

    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(
        countryRepository: Get.find<CountryRepository>(),
        connectionRepository: Get.find<ConnectionRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CountrySelectionViewModel>(
      () => CountrySelectionViewModel(
        countryRepository: Get.find<CountryRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<DisconnectViewmodel>(() => DisconnectViewmodel(), fenix: true);
    Get.lazyPut<ThemeController>(() => ThemeController(), fenix: true);
  }
}
