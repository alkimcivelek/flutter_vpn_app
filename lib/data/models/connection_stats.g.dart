// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionStats _$ConnectionStatsFromJson(Map<String, dynamic> json) =>
    ConnectionStats(
      id: json['id'] as String,
      downloadSpeed: (json['downloadSpeed'] as num).toInt(),
      uploadSpeed: (json['uploadSpeed'] as num).toInt(),
      connectedTime: Duration(
        microseconds: (json['connectedTime'] as num).toInt(),
      ),
      connectedCountry: json['connectedCountry'] == null
          ? null
          : Country.fromJson(json['connectedCountry'] as Map<String, dynamic>),
      connectionStartTime: json['connectionStartTime'] == null
          ? null
          : DateTime.parse(json['connectionStartTime'] as String),
      isConnecting: json['isConnecting'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String?,
      dataUsed: (json['dataUsed'] as num?)?.toInt() ?? 0,
      status:
          $enumDecodeNullable(_$ConnectionStatusEnumMap, json['status']) ??
          ConnectionStatus.disconnected,
    );

Map<String, dynamic> _$ConnectionStatsToJson(ConnectionStats instance) =>
    <String, dynamic>{
      'id': instance.id,
      'downloadSpeed': instance.downloadSpeed,
      'uploadSpeed': instance.uploadSpeed,
      'connectedTime': instance.connectedTime.inMicroseconds,
      'connectedCountry': instance.connectedCountry,
      'connectionStartTime': instance.connectionStartTime?.toIso8601String(),
      'isConnecting': instance.isConnecting,
      'errorMessage': instance.errorMessage,
      'dataUsed': instance.dataUsed,
      'status': _$ConnectionStatusEnumMap[instance.status]!,
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.disconnected: 'disconnected',
  ConnectionStatus.connecting: 'connecting',
  ConnectionStatus.connected: 'connected',
  ConnectionStatus.disconnecting: 'disconnecting',
  ConnectionStatus.error: 'error',
};
