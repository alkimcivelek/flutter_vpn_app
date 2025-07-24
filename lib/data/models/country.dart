import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country extends Equatable {
  final String id;
  final String name;
  final String flag;
  final String? city;
  final int locationCount;
  final int strength;
  final bool isConnected;

  const Country({
    required this.id,
    required this.name,
    required this.flag,
    this.city,
    required this.locationCount,
    required this.strength,
    this.isConnected = false,
  });

  Country copyWith({
    required String id,
    required String name,
    required String flag,
    String? city,
    int? locationCount,
    int? strength,
    bool? isConnected,
  }) {
    return Country(
      id: id,
      name: name,
      flag: flag,
      city: city ?? this.city,
      locationCount: locationCount ?? this.locationCount,
      strength: strength ?? this.strength,
      isConnected: isConnected ?? this.isConnected,
    );
  }

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    flag,
    city,
    locationCount,
    strength,
    isConnected,
  ];

  String get displayName => city?.isNotEmpty == true ? '$city, $name' : name;

  bool get hasStrongSignal => strength >= 80;
  bool get hasMediumSignal => strength >= 50 && strength < 80;
  bool get hasWeakSignal => strength < 50;

  String get signalQuality {
    if (hasStrongSignal) return 'Excellent';
    if (hasMediumSignal) return 'Good';
    return 'Poor';
  }
}
