import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vpn_app/data/models/connection_stats.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/widgets/common/loading_indicator.dart';
import 'package:get/get.dart';

class ConnectionInfoCard extends StatelessWidget {
  ConnectionInfoCard({super.key});

  final HomeViewModel controller = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final stats = controller.connectionStats;
      final isConnected = stats.status == ConnectionStatus.connected;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            Text(
              'Connecting Time',
              style: TextStyle(
                color: theme.textTheme.titleLarge!.color,
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
              ),
            ),
            4.verticalSpace,
            Text(
              stats.formattedConnectionTime,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: theme.textTheme.titleLarge!.color,
              ),
            ),

            24.verticalSpace,

            if (isConnected && stats.connectedCountry != null)
              _buildConnectedCountryInfo(stats, theme)
            else
              controller.isConnecting
                  ? LoadingIndicator()
                  : _buildDisconnectedState(theme),
          ],
        ),
      );
    });
  }

  Widget _buildConnectedCountryInfo(ConnectionStats stats, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 56),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            stats.connectedCountry!.flag,
            width: 42.w,
            fit: BoxFit.fitWidth,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey,
                child: Center(
                  child: Text(
                    stats.connectedCountry!.name,
                    style: const TextStyle(fontSize: 8, color: Colors.white),
                  ),
                ),
              );
            },
          ),

          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stats.connectedCountry!.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.titleMedium!.color,
                  ),
                ),
                if (stats.connectedCountry!.city != null)
                  Text(
                    stats.connectedCountry!.city!,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: theme.textTheme.bodySmall!.color,
                    ),
                  ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Stealth',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.titleMedium!.color,
                ),
              ),
              Text(
                '${stats.connectedCountry!.strength}%',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: theme.textTheme.titleMedium!.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisconnectedState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.power_settings_new, color: Colors.grey[400], size: 24),
          12.horizontalSpace,
          Text(
            'Not Connected',
            style: TextStyle(
              fontSize: 16,
              color: theme.textTheme.bodyMedium!.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
