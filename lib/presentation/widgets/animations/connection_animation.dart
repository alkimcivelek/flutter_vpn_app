import 'package:flutter/material.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';

class ConnectionAnimation extends StatefulWidget {
  final bool isActive;
  final double size;
  final Color? color;

  const ConnectionAnimation({
    super.key,
    required this.isActive,
    this.size = 120,
    this.color,
  });

  @override
  State<ConnectionAnimation> createState() => _ConnectionAnimationState();
}

class _ConnectionAnimationState extends State<ConnectionAnimation>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    if (widget.isActive) {
      _startAnimations();
    }
  }

  @override
  void didUpdateWidget(ConnectionAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _startAnimations();
      } else {
        _stopAnimations();
      }
    }
  }

  void _startAnimations() {
    _pulseController.repeat();
    _rotationController.repeat();
  }

  void _stopAnimations() {
    _pulseController.stop();
    _rotationController.stop();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? ColorConstants.primaryBlue;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse rings
          if (widget.isActive) ...[
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                return Container(
                  width: widget.size * (0.6 + 0.4 * _pulseController.value),
                  height: widget.size * (0.6 + 0.4 * _pulseController.value),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withValues(
                        alpha: 1 - _pulseController.value,
                      ),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final delayedValue = (_pulseController.value + 0.3) % 1.0;
                return Container(
                  width: widget.size * (0.6 + 0.4 * delayedValue),
                  height: widget.size * (0.6 + 0.4 * delayedValue),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: color.withValues(alpha: 1 - delayedValue),
                      width: 2,
                    ),
                  ),
                );
              },
            ),
          ],
          // Center circle
          Container(
            width: widget.size * 0.4,
            height: widget.size * 0.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              widget.isActive ? Icons.vpn_key : Icons.vpn_key_off,
              color: ColorConstants.textWhite,
              size: widget.size * 0.15,
            ),
          ),
        ],
      ),
    );
  }
}
