import 'package:equatable/equatable.dart';
import 'package:flutter_vpn_app/data/models/country.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_stats.g.dart';

@JsonSerializable()
class ConnectionStats extends Equatable {
  final String id;
  final int downloadSpeed; // MB/s
  final int uploadSpeed; // MB/s
  final Duration connectedTime;
  final Country? connectedCountry;
  final DateTime? connectionStartTime;
  final bool isConnecting;
  final String? errorMessage;
  final int dataUsed; // MB
  final ConnectionStatus status;

  const ConnectionStats({
    required this.id,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.connectedTime,
    this.connectedCountry,
    this.connectionStartTime,
    this.isConnecting = false,
    this.errorMessage,
    this.dataUsed = 0,
    this.status = ConnectionStatus.disconnected,
  });

  ConnectionStats copyWith({
    required String id,
    int? downloadSpeed,
    int? uploadSpeed,
    Duration? connectedTime,
    Country? connectedCountry,
    DateTime? connectionStartTime,
    bool? isConnecting,
    String? errorMessage,
    int? dataUsed,
    ConnectionStatus? status,
  }) {
    return ConnectionStats(
      id: id,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      connectedTime: connectedTime ?? this.connectedTime,
      connectedCountry: connectedCountry ?? this.connectedCountry,
      connectionStartTime: connectionStartTime ?? this.connectionStartTime,
      isConnecting: isConnecting ?? this.isConnecting,
      errorMessage: errorMessage ?? this.errorMessage,
      dataUsed: dataUsed ?? this.dataUsed,
      status: status ?? this.status,
    );
  }

  factory ConnectionStats.fromJson(Map<String, dynamic> json) =>
      _$ConnectionStatsFromJson(json);
  Map<String, dynamic> toJson() => _$ConnectionStatsToJson(this);

  @override
  List<Object?> get props => [
    id,
    downloadSpeed,
    uploadSpeed,
    connectedTime,
    connectedCountry,
    connectionStartTime,
    isConnecting,
    errorMessage,
    dataUsed,
    status,
  ];

  bool get isConnected => status == ConnectionStatus.connected;
  bool get isDisconnected => status == ConnectionStatus.disconnected;

  String get formattedConnectionTime {
    final hours = connectedTime.inHours.toString().padLeft(2, '0');
    final minutes = (connectedTime.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (connectedTime.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String get formattedDataUsed {
    if (dataUsed < 1024) {
      return '${dataUsed}MB';
    }
    return '${(dataUsed / 1024).toStringAsFixed(1)}GB';
  }

  double get averageSpeed => (downloadSpeed + uploadSpeed) / 2;

  String get speedQuality {
    if (averageSpeed >= 100) return 'Excellent';
    if (averageSpeed >= 50) return 'Good';
    if (averageSpeed >= 25) return 'Fair';
    return 'Poor';
  }
}

enum ConnectionStatus {
  @JsonValue('disconnected')
  disconnected,
  @JsonValue('connecting')
  connecting,
  @JsonValue('connected')
  connected,
  @JsonValue('disconnecting')
  disconnecting,
  @JsonValue('error')
  error,
}
