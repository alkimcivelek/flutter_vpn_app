import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';
import 'package:get/get_connect/sockets/src/sockets_html.dart';

class ConnectionStatusIndicator extends StatelessWidget {
  final ConnectionStatus status;
  final double size;
  final bool showText;

  const ConnectionStatusIndicator({
    super.key,
    required this.status,
    this.size = 12,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildStatusDot(),
        if (showText) ...[
          const SizedBox(width: 8),
          Text(
            _getStatusText(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: _getStatusColor(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStatusDot() {
    if (status == ConnectionStatus.connecting ||
        status == ConnectionStatus.disconnected) {
      return Pulse(
        infinite: true,
        duration: const Duration(milliseconds: 1000),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: _getStatusColor(),
            shape: BoxShape.circle,
          ),
        ),
      );
    }

    return FadeIn(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: _getStatusColor(),
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case ConnectionStatus.connected:
        return ColorConstants.connectedGreen;
      case ConnectionStatus.connecting:
      case ConnectionStatus.disconnecting:
        return ColorConstants.connectingYellow;
      case ConnectionStatus.disconnected:
        return ColorConstants.disconnectedGray;
      case ConnectionStatus.error:
        return ColorConstants.errorRed;
      case ConnectionStatus.closed:
        throw UnimplementedError();
    }
  }

  String _getStatusText() {
    switch (status) {
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.connecting:
        return 'Connecting...';
      case ConnectionStatus.disconnecting:
        return 'Disconnecting...';
      case ConnectionStatus.disconnected:
        return 'Disconnected';
      case ConnectionStatus.error:
        return 'Error';
      case ConnectionStatus.closed:
        throw UnimplementedError();
    }
  }
}
