import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vpn_app/core/constants/asset_constants.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:get/get.dart';

class SpeedStatsRow extends StatelessWidget {
  SpeedStatsRow({super.key});

  final HomeViewModel controller = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final stats = controller.connectionStats;

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 56),
        child: Row(
          children: [
            Expanded(
              child: _buildSpeedCard(
                theme: theme,
                image: SvgPicture.asset(
                  AssetConstants.downloadIcon,
                  width: 24.w,
                  fit: BoxFit.fitWidth,
                  color: Color(0xff00D589),
                ),
                label: 'Download :',
                value: '${stats.downloadSpeed} MB',
                color: const Color(0xff00D589).withValues(alpha: 0.15),
              ),
            ),
            8.horizontalSpace,
            Expanded(
              child: _buildSpeedCard(
                theme: theme,
                image: SvgPicture.asset(
                  AssetConstants.uploadIcon,
                  color: Color(0xffE63946),
                  width: 24.w,
                  fit: BoxFit.fitWidth,
                ),
                label: 'Upload :',
                value: '${stats.uploadSpeed} MB',
                color: const Color(0xffE63946).withValues(alpha: 0.15),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSpeedCard({
    required ThemeData theme,
    required SvgPicture image,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xff00091F).withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: image,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.titleLarge!.color,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.titleLarge!.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
