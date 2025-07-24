import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';

enum AppButtonType { primary, secondary, outline, text }

enum AppButtonSize { small, medium, large }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final Widget? customChild;
  final double? width;
  final Color? color;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.customChild,
    this.width,
    this.color,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled =
        widget.onPressed != null && !widget.isLoading && !widget.isDisabled;

    return GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: SizedBox(
          width: widget.width,
          height: _getButtonHeight(),
          child: ElevatedButton(
            onPressed: isEnabled ? widget.onPressed : null,
            style: _getButtonStyle(theme, isEnabled),
            child: widget.isLoading
                ? _buildLoadingIndicator()
                : widget.customChild ?? _buildButtonContent(),
          ),
        ),
      ),
    );
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 36;
      case AppButtonSize.medium:
        return 48;
      case AppButtonSize.large:
        return 56;
    }
  }

  ButtonStyle _getButtonStyle(ThemeData theme, bool isEnabled) {
    final baseColor = widget.color ?? ColorConstants.primaryBlue;

    Color backgroundColor;
    Color foregroundColor;
    Color? borderColor;

    switch (widget.type) {
      case AppButtonType.primary:
        backgroundColor = isEnabled
            ? baseColor
            : baseColor.withValues(alpha: 0.3);
        foregroundColor = ColorConstants.textWhite;
        break;
      case AppButtonType.secondary:
        backgroundColor = isEnabled
            ? baseColor.withValues(alpha: 0.1)
            : baseColor.withValues(alpha: 0.05);
        foregroundColor = isEnabled
            ? baseColor
            : baseColor.withValues(alpha: 0.5);
        break;
      case AppButtonType.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = isEnabled
            ? baseColor
            : baseColor.withValues(alpha: 0.5);
        borderColor = isEnabled ? baseColor : baseColor.withValues(alpha: 0.3);
        break;
      case AppButtonType.text:
        backgroundColor = Colors.transparent;
        foregroundColor = isEnabled
            ? baseColor
            : baseColor.withValues(alpha: 0.5);
        break;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: widget.type == AppButtonType.primary ? 2 : 0,
      shadowColor: Colors.black26,
      side: borderColor != null ? BorderSide(color: borderColor) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: 0,
      ),
    );
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 12;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 20;
    }
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 20.w,
      height: 20.w,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.type == AppButtonType.primary
              ? ColorConstants.textWhite
              : ColorConstants.primaryBlue,
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    final textStyle = TextStyle(
      fontSize: _getFontSize(),
      fontWeight: FontWeight.w600,
    );

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: _getIconSize()),
          const SizedBox(width: 8),
          Text(widget.text, style: textStyle),
        ],
      );
    }

    return Text(widget.text, style: textStyle);
  }

  double _getFontSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 14;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 18;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 18;
      case AppButtonSize.large:
        return 20;
    }
  }
}
