import 'package:flutter_vpn_app/app/bindings/initial_binding.dart';
import 'package:flutter_vpn_app/app/routes/app_routes.dart';
import 'package:flutter_vpn_app/presentation/views/country_selection/country_selection_view.dart';
import 'package:flutter_vpn_app/presentation/views/disconnect/disconnect_view.dart';
import 'package:flutter_vpn_app/presentation/views/home/home_view.dart';
import 'package:flutter_vpn_app/presentation/views/main/main_view.dart';
import 'package:flutter_vpn_app/presentation/views/setting/setting_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.countrySelection,
      page: () => const CountrySelectionView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.disconnect,
      page: () => const DisconnectView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainView(),
      binding: InitialBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
