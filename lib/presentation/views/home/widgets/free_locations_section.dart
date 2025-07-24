import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vpn_app/core/constants/asset_constants.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class FreeLocationsSection extends StatelessWidget {
  const FreeLocationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<HomeViewModel>(
      builder: (homeController) {
        if (homeController.isLoading) {
          return _buildLoadingState();
        }

        final freeCountries = homeController.countries.getRange(0, 4).toList();

        return Container(
          margin: const EdgeInsets.only(
            top: 24,
            right: 32,
            left: 32,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Free Locations (${freeCountries.length})',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    AssetConstants.infoCircleIcon,
                    width: 16.w,
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
              4.verticalSpace,
              ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: freeCountries.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    child: FreeLocationItem(
                      country: freeCountries[index],
                      homeController: homeController,
                      theme: theme,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16.w,
                      width: 100.w,
                      color: Colors.grey[300],
                    ),
                    4.verticalSpace,
                    Container(
                      height: 12.w,
                      width: 80.w,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FreeLocationItem extends StatelessWidget {
  final Country country;
  final HomeViewModel homeController;
  final ThemeData theme;
  const FreeLocationItem({
    super.key,
    required this.country,
    required this.homeController,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final connectionStats = homeController.connectionStats;
    final isConnecting = homeController.isConnecting;

    final isCurrentCountry = connectionStats.connectedCountry?.id == country.id;
    final isConnectedToThis =
        isCurrentCountry &&
        (connectionStats.status == ConnectionStatus.connected);

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Flag
          SvgPicture.asset(
            country.flag,
            width: 42.w,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: theme.textTheme.titleSmall!.color,
                child: Center(
                  child: Text(
                    country.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              );
            },
          ),
          12.horizontalSpace,
          // Country Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isConnectedToThis
                        ? ColorConstants.connectedGreen
                        : theme.textTheme.titleMedium!.color,
                  ),
                ),
                Text(
                  '${country.locationCount} Locations',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: theme.textTheme.labelSmall!.color,
                  ),
                ),
              ],
            ),
          ),

          // Action Button
          if (isConnecting && isCurrentCountry)
            SizedBox(
              width: 24.w,
              height: 24.w,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          else
            GestureDetector(
              onTap: isConnecting ? null : () => _handleCountryTap(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isConnectedToThis
                      ? Color(0xff185BFF)
                      : theme.textTheme.bodySmall!.color!.withValues(
                          alpha: 0.2,
                        ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isConnecting
                    ? CircularProgressIndicator(strokeWidth: 2)
                    : SvgPicture.asset(
                        AssetConstants.powerIcon,
                        width: 20.w,
                        height: 20.w,
                        color: isConnectedToThis
                            ? theme.cardTheme.color
                            : theme.iconTheme.color,
                      ),
              ),
            ),

          8.horizontalSpace,
          Container(
            padding: const EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: theme.textTheme.bodySmall!.color!.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              AssetConstants.arrowRightIcon,
              width: 20.w,
              height: 20.w,
              color: theme.iconTheme.color,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCountryTap() async {
    final isCurrentCountry =
        homeController.connectionStats.connectedCountry?.id == country.id;
    final isConnected = isCurrentCountry && homeController.isConnected;

    if (isConnected) {
      await homeController.disconnect();
    } else {
      await homeController.connectToCountry(country);
    }
  }
}
