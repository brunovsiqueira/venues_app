import 'package:equatable/equatable.dart';

class VenueModel extends Equatable {
  final String id;
  final String name;
  final String? shortDescription;
  final String? distance;
  final String? score;
  final String? deliveryPrice;
  final String? estimateRange;

  const VenueModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    this.distance,
    this.score,
    this.deliveryPrice,
    this.estimateRange,
  });

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
        id: json['id'],
        name: json['name'],
        shortDescription: json['short_description']);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        shortDescription,
        distance,
        score,
        deliveryPrice,
        estimateRange
      ];
}
