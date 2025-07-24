import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/presentation/widgets/common/app_card.dart';

class CountrySelectionListItem extends StatelessWidget {
  final Country country;
  final VoidCallback onTap;

  const CountrySelectionListItem({
    super.key,
    required this.country,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SvgPicture.asset(
                country.flag,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: theme.cardColor.withValues(alpha: 0.3),
                    child: Center(
                      child: Text(
                        country.name,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.name,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    2.verticalSpace,
                    Text(
                      country.city ?? "",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        Text(
                          '${country.locationCount} locations',
                          style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 12.sp,
                          ),
                        ),
                        12.verticalSpace,
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: _getSignalColor(
                              country.strength,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${country.strength}%',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: _getSignalColor(country.strength),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConstants.connectedGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'FREE',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Arrow Icon
          Icon(
            Icons.keyboard_arrow_right,
            color: theme.iconTheme.color,
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  Color _getSignalColor(int strength) {
    if (strength >= 80) return ColorConstants.connectedGreen;
    if (strength >= 50) return ColorConstants.warningOrange;
    return ColorConstants.errorRed;
  }
}
