import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/presentation/controllers/theme_controller.dart';
import 'package:get/get.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(child: _buildMainContent(theme)),
    );
  }

  Widget _buildMainContent(ThemeData theme) {
    return GetBuilder<ThemeController>(
      builder: (controller) {
        return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme Settings',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: themeController.themeModeOptions
                      .map(
                        (option) => InkWell(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => controller.setTheme(option.mode),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(option.icon, size: 24.w),
                            title: Text(
                              option.title,
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            subtitle: Text(
                              option.subtitle,
                              style: theme.textTheme.titleSmall!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            trailing: Obx(
                              () => Radio<ThemeMode>(
                                value: option.mode,
                                groupValue: themeController.currentTheme,
                                onChanged: (mode) =>
                                    themeController.setTheme(mode!),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
