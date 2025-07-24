import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/disconnect_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/views/disconnect/widgets/connection_pulse.dart';
import 'package:get/get.dart';

class DisconnectView extends GetView<DisconnectViewmodel> {
  const DisconnectView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: SafeArea(child: _buildMainContent(theme)),
      ),
    );
  }

  Widget _buildMainContent(ThemeData theme) {
    return Obx(() {
      final isConnected = controller.homeController.isConnected;
      final connectionStats = controller.homeController.connectionStats;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeIn(
            duration: const Duration(milliseconds: 1000),
            child: Stack(
              alignment: Alignment.center,
              children: [
                GetBuilder<DisconnectViewmodel>(
                  builder: (disconnectController) => ConnectionPulse(
                    controller: disconnectController.pulseController,
                    isActive: isConnected,
                  ),
                ),

                _buildMainCircle(theme, isConnected),
                _buildStatusIndicator(theme, isConnected),
              ],
            ),
          ),

          40.verticalSpace,

          if (isConnected && connectionStats.connectedCountry != null)
            _buildConnectionInfo(theme, connectionStats),
        ],
      );
    });
  }

  Widget _buildMainCircle(ThemeData theme, bool isConnected) {
    return GetBuilder<DisconnectViewmodel>(
      builder: (disconnectController) => InkWell(
        onTap: () => disconnectController.homeController.handleDisconnectTap(),
        child: Container(
          width: 200.w,
          height: 200.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: isConnected
                  ? [ColorConstants.primaryBlue, ColorConstants.infoBlue]
                  : [ColorConstants.textLight, ColorConstants.textGray],
            ),
            boxShadow: [
              BoxShadow(
                color:
                    (isConnected
                            ? ColorConstants.primaryBlue
                            : theme.textTheme.titleSmall!.color!)
                        .withValues(alpha: 0.2),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160.w,
                height: 160.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
              ),

              Icon(
                Icons.power_settings_new,
                size: 80.sp,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    offset: const Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(ThemeData theme, bool isConnected) {
    return Positioned(
      bottom: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xff00091F).withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          isConnected ? 'CONNECTED' : 'DISCONNECTED',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildConnectionInfo(ThemeData theme, dynamic connectionStats) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: theme.shadowColor.withValues(alpha: 0.4),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SvgPicture.asset(
                      connectionStats.connectedCountry!.flag,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: theme.textTheme.titleSmall!.color,
                          child: Center(
                            child: Text(
                              connectionStats.connectedCountry!.name,
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: theme.textTheme.titleMedium!.color,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  connectionStats.connectedCountry!.displayName,
                  style: TextStyle(
                    color: theme.textTheme.titleMedium!.color,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Connected for ${connectionStats.formattedConnectionTime}',
              style: TextStyle(
                color: theme.textTheme.titleMedium!.color,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
