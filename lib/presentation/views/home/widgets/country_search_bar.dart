import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/views/country_selection/country_selection_view.dart';
import 'package:get/get.dart';

class CountrySearchBar extends StatelessWidget {
  const CountrySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeController = Get.find<HomeViewModel>();

    return FadeInDown(
      child: GestureDetector(
        onTap: () => _openCountrySelection(context),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: ColorConstants.textGray, size: 20.sp),
              12.horizontalSpace,
              Expanded(
                child: Obx(() {
                  final connectedCountry =
                      homeController.connectionStats.connectedCountry;

                  return Text(
                    connectedCountry != null
                        ? 'Connected to ${connectedCountry.displayName}'
                        : 'Search for countries...',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: connectedCountry != null
                          ? theme.textTheme.bodyLarge?.color
                          : ColorConstants.textGray,
                    ),
                  );
                }),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: ColorConstants.textGray,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCountrySelection(BuildContext context) async {
    final selectedCountry = await Get.to<dynamic>(
      () => const CountrySelectionView(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );

    if (selectedCountry != null) {
      final homeController = Get.find<HomeViewModel>();
      await homeController.connectToCountry(selectedCountry);
    }
  }
}
