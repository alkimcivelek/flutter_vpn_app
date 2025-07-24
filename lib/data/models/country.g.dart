// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
  id: json['id'] as String,
  name: json['name'] as String,
  flag: json['flag'] as String,
  city: json['city'] as String?,
  locationCount: (json['locationCount'] as num).toInt(),
  strength: (json['strength'] as num).toInt(),
  isConnected: json['isConnected'] as bool? ?? false,
);

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'flag': instance.flag,
  'city': instance.city,
  'locationCount': instance.locationCount,
  'strength': instance.strength,
  'isConnected': instance.isConnected,
};
