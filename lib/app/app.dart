import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/app/routes/app_pages.dart';
import 'package:flutter_vpn_app/app/routes/app_routes.dart';
import 'package:flutter_vpn_app/app/theme/app_theme.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:get/get.dart';

class VPNApp extends StatelessWidget {
  const VPNApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: ProviderScope(
        child: GetMaterialApp(
          title: 'VPN App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.initial,
          getPages: AppPages.routes,
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: _getSystemUiOverlayStyle(context),
              child: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              ),
            );
          },
          unknownRoute: GetPage(
            name: AppRoutes.notFound,
            page: () => const NotFoundScreen(),
          ),
        ),
      ),
    );
  }

  SystemUiOverlayStyle _getSystemUiOverlayStyle(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarColor: brightness == Brightness.dark
          ? ColorConstants.backgroundDark
          : ColorConstants.backgroundLight,
      systemNavigationBarIconBrightness: brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}

// Error page for unknown routes
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: ColorConstants.errorRed),
            const SizedBox(height: 16),
            Text(
              '404 - Page Not Found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'The page you are looking for does not exist.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.main),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
