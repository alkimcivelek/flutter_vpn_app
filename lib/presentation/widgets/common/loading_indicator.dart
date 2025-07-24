import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final Color? color;
  final String? message;

  const LoadingIndicator({super.key, this.size = 24, this.color, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Pulse(
          infinite: true,
          duration: const Duration(milliseconds: 1200),
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? ColorConstants.primaryBlue,
            ),
          ),
        ),
        if (message != null) ...[
          16.verticalSpace,
          FadeInUp(
            child: Text(
              message!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ],
    );
  }
}
