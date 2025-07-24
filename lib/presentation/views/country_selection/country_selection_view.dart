import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/presentation/viewmodels/country_selection_viewmodel.dart';
import 'package:flutter_vpn_app/presentation/views/country_selection/widgets/country_list_item.dart';
import 'package:get/get.dart';

class CountrySelectionView extends GetView<CountrySelectionViewModel> {
  const CountrySelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: FadeInDown(
          child: Text(
            'Select Country',
            style: theme.textTheme.titleLarge!.copyWith(fontSize: 16.sp),
          ),
        ),
        leading: FadeInLeft(
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 24.sp,
              color: theme.iconTheme.color,
            ),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            FadeInDown(
              delay: const Duration(milliseconds: 200),
              child: TextField(
                controller: controller.textController,
                onChanged: controller.searchCountries,
                decoration: InputDecoration(
                  hintText: 'Search countries...',
                  hintStyle: TextStyle(fontSize: 12.sp),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GetBuilder<CountrySelectionViewModel>(
                    builder: (ctrl) => ctrl.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: ctrl.clearSearch,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ),
            16.verticalSpace,
            // Countries List
            Expanded(
              child: GetBuilder<CountrySelectionViewModel>(
                builder: (ctrl) {
                  if (ctrl.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final countries = ctrl.filteredCountries;
                  if (countries.isEmpty) {
                    return FadeInUp(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64.sp,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                            16.verticalSpace,
                            Text(
                              'No countries found',
                              style: theme.textTheme.headlineSmall!.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            8.verticalSpace,
                            Text(
                              'Try again',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: countries.length,
                    separatorBuilder: (context, index) => 8.verticalSpace,
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        delay: Duration(milliseconds: 50 * index),
                        child: CountrySelectionListItem(
                          country: countries[index],
                          onTap: () =>
                              controller.selectCountry(countries[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
