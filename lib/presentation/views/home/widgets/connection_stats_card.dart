import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/widgets/animations/connection_animation.dart';
import 'package:flutter_vpn_app/presentation/widgets/common/app_card.dart';
import 'package:get/get.dart';

class ConnectionStatsCard extends StatelessWidget {
  const ConnectionStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeViewModel>();

    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Obx(
        () => _buildStatsContent(
          context,
          homeController.connectionStats,
          homeController.lastConnectionCountry,
        ),
      ),
    );
  }

  Widget _buildStatsContent(
    BuildContext context,
    ConnectionStats stats,
    Country? lastCountry,
  ) {
    final theme = Theme.of(context);
    final isConnected = stats.status == ConnectionStatus.connected;
    final isConnecting = stats.status == ConnectionStatus.connecting;

    return Column(
      children: [
        FadeInDown(
          child: ConnectionAnimation(
            isActive: isConnected || isConnecting,
            size: 100,
          ),
        ),

        16.verticalSpace,

        FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: _buildConnectionStatus(context, stats, lastCountry, theme),
        ),

        const SizedBox(height: 24),

        FadeInUp(
          delay: const Duration(milliseconds: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                context,
                icon: Icons.download,
                label: 'Download',
                value: '${stats.downloadSpeed} MB/s',
                color: ColorConstants.successGreen,
              ),
              _buildVerticalDivider(),
              _buildStatItem(
                context,
                icon: Icons.access_time,
                label: 'Time',
                value: stats.formattedConnectionTime,
                color: theme.primaryColor,
              ),
              _buildVerticalDivider(),
              _buildStatItem(
                context,
                icon: Icons.upload,
                label: 'Upload',
                value: '${stats.uploadSpeed} MB/s',
                color: ColorConstants.warningOrange,
              ),
            ],
          ),
        ),

        if (isConnected && stats.dataUsed > 0) ...[
          16.verticalSpace,
          FadeInUp(
            delay: const Duration(milliseconds: 600),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ColorConstants.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Data used: ${stats.formattedDataUsed}',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: 12.sp,
                  color: ColorConstants.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildConnectionStatus(
    BuildContext context,
    ConnectionStats stats,
    Country? lastCountry,
    ThemeData theme,
  ) {
    final isConnected = stats.status == ConnectionStatus.connected;

    if (stats.connectedCountry != null && isConnected) {
      return Column(
        children: [
          Text(
            stats.connectedCountry!.displayName,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorConstants.connectedGreen,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 24.w,
                height: 16.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: SvgPicture.asset(
                    stats.connectedCountry!.flag,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: theme.textTheme.titleSmall!.color,
                        child: Center(
                          child: Text(
                            stats.connectedCountry!.name,
                            style: TextStyle(
                              fontSize: 8.sp,
                              color: theme.textTheme.bodySmall!.color,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              8.horizontalSpace,
              Text(
                '${stats.connectedCountry!.strength}% Signal',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: _getSignalColor(stats.connectedCountry!.strength),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      );
    }

    String statusText;
    Color statusColor;

    switch (stats.status) {
      case ConnectionStatus.connected:
        statusText = 'Connected';
        statusColor = ColorConstants.connectedGreen;
        break;
      case ConnectionStatus.connecting:
        statusText = 'Connecting...';
        statusColor = ColorConstants.connectingYellow;
        break;
      case ConnectionStatus.disconnecting:
        statusText = 'Disconnecting...';
        statusColor = ColorConstants.warningOrange;
        break;
      case ConnectionStatus.error:
        statusText = 'Connection Error';
        statusColor = ColorConstants.errorRed;
        break;
      default:
        statusText = lastCountry?.displayName ?? 'Not Connected';
        statusColor = theme.textTheme.bodyMedium?.color ?? Colors.grey;
    }

    return Text(
      statusText,
      style: theme.textTheme.headlineMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: statusColor,
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.cardColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        8.verticalSpace,
        Text(
          value,
          style: theme.textTheme.labelLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        2.verticalSpace,
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
            color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.withValues(alpha: 0.3),
    );
  }

  Color _getSignalColor(int strength) {
    if (strength >= 80) return ColorConstants.connectedGreen;
    if (strength >= 50) return ColorConstants.warningOrange;
    return ColorConstants.errorRed;
  }
}
