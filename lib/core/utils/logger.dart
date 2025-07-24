import 'package:flutter/foundation.dart';

class Logger {
  static const String _prefix = '[VPN_APP]';

  static void debug(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix DEBUG: $message ${data != null ? '- $data' : ''}');
    }
  }

  static void info(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix INFO: $message ${data != null ? '- $data' : ''}');
    }
  }

  static void warning(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix WARNING: $message ${data != null ? '- $data' : ''}');
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('$_prefix ERROR: $message ${error != null ? '- $error' : ''}');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }

  static void network(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix NETWORK: $message ${data != null ? '- $data' : ''}');
    }
  }

  static void connection(String message, [dynamic data]) {
    if (kDebugMode) {
      print('$_prefix CONNECTION: $message ${data != null ? '- $data' : ''}');
    }
  }
}
