import 'package:equatable/equatable.dart';

class CoordinatesModel extends Equatable {
  final double latitude;
  final double longitude;

  const CoordinatesModel({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toQueryParams() {
    return {
      'lat': latitude,
      'long': longitude,
    };
  }

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];
}
