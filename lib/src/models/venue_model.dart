import 'package:equatable/equatable.dart';

class VenueModel extends Equatable {
  final String id;
  final String name;
  final String? shortDescription;
  final String? distance;
  final double? score;
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
    double? score;
    if (json case {'rating': {'score': var matchedScore}}) {
      score = matchedScore;
    }
    return VenueModel(
      id: json['id'],
      name: json['name'],
      shortDescription: json['short_description'],
      distance: json['distance'],
      score: score,
      deliveryPrice: json['deliveryPrice'],
      estimateRange: json['estimateRange'],
    );
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
