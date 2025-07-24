import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/views/home/widgets/connection_info_card.dart';
import 'package:flutter_vpn_app/presentation/views/home/widgets/free_locations_section.dart';
import 'package:flutter_vpn_app/presentation/views/home/widgets/gradient_header.dart';
import 'package:flutter_vpn_app/presentation/views/home/widgets/speed_stats_row.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: GetBuilder<HomeViewModel>(
        builder: (homeController) => RefreshIndicator(
          onRefresh: () => homeController.refreshData(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Header
              SliverToBoxAdapter(
                child: FadeInDown(child: const GradientHeader()),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    4.verticalSpace,
                    // Connection Info Card
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      child: ConnectionInfoCard(),
                    ),
                    8.verticalSpace,
                    // Speed Stats Row
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: SpeedStatsRow(),
                    ),
                    // Free Locations Section
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      child: const FreeLocationsSection(),
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
