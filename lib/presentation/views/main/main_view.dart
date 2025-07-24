import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vpn_app/core/constants/asset_constants.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/presentation/providers/main_provider.dart';
import 'package:flutter_vpn_app/presentation/views/disconnect/disconnect_view.dart';
import 'package:flutter_vpn_app/presentation/views/home/home_view.dart';
import 'package:flutter_vpn_app/presentation/views/setting/setting_view.dart';

class MainView extends ConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      backgroundColor: theme.cardTheme.color,
      body: IndexedStack(
        index: selectedIndex,
        children: [HomeView(), DisconnectView(), SettingView()],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Navigation bar
          Container(
            height: 100.h,
            padding: EdgeInsets.only(
              left: 8.w,
              right: 8.w,
              top: 8.h,
              bottom: MediaQuery.of(context).padding.bottom + 8.h,
            ),
            decoration: BoxDecoration(
              color: theme.bottomNavigationBarTheme.backgroundColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  ref: ref,
                  index: 0,
                  iconAsset: AssetConstants.mapIcon,
                  label: 'Countries',
                  theme: theme,
                  selectedIndex: selectedIndex,
                ),
                _buildNavItem(
                  ref: ref,
                  index: 1,
                  iconAsset: AssetConstants.radarIcon,
                  label: 'Disconnect',
                  theme: theme,
                  selectedIndex: selectedIndex,
                ),
                _buildNavItem(
                  ref: ref,
                  index: 2,
                  iconAsset: AssetConstants.settingIcon,
                  label: 'Settings',
                  theme: theme,
                  selectedIndex: selectedIndex,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required WidgetRef ref,
    required int index,
    required String iconAsset,
    required String label,
    required ThemeData theme,
    required int selectedIndex,
  }) {
    final isSelected = selectedIndex == index;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () => _handleNavTap(ref, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconAsset,
            height: 24.w,
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
            color: isSelected
                ? ColorConstants.primaryBlue
                : theme.textTheme.bodyLarge?.color,
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? ColorConstants.primaryBlue
                  : theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavTap(WidgetRef ref, int index) {
    ref.read(mainProvider.notifier).changeIndex(index);
  }
}
