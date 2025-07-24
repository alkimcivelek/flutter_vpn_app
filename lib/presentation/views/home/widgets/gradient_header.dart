import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vpn_app/core/constants/asset_constants.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/views/country_selection/country_selection_view.dart';
import 'package:get/get.dart';

class GradientHeader extends StatelessWidget {
  const GradientHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          ),

          child: Image.asset(
            AssetConstants.headerBackground,
            fit: BoxFit.fitWidth,
            width: double.infinity,
          ),
        ),

        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Top Row with Menu and Crown
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff3B74FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        AssetConstants.categoryIcon,
                        height: 24.w,
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Countries',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xff3B74FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(
                        AssetConstants.premiumIcon,
                        height: 24.w,
                        alignment: Alignment.center,
                        fit: BoxFit.fitWidth,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                24.verticalSpace,
                // Search Bar
                GestureDetector(
                  onTap: () => _openCountrySelection(),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 56.w,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.h,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'Search For Country Or City',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            AssetConstants.searchIcon,
                            height: 24.w,
                            width: 24.w,
                            color: Color(0xff292D32),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _openCountrySelection() async {
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
