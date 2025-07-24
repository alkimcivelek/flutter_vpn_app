import 'package:flutter/material.dart';

class ConnectionPulse extends StatelessWidget {
  final AnimationController controller;
  final bool isActive;

  const ConnectionPulse({
    super.key,
    required this.controller,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    if (!isActive) return const SizedBox();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 280 + (controller.value * 40),
              height: 280 + (controller.value * 40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(
                    0xFF4CAF50,
                  ).withValues(alpha: 0.3 * (1 - controller.value)),
                  width: 2,
                ),
              ),
            ),
            Container(
              width: 240 + (controller.value * 30),
              height: 240 + (controller.value * 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(
                    0xFF4CAF50,
                  ).withValues(alpha: 0.5 * (1 - controller.value)),
                  width: 3,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
