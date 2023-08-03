import 'package:equatable/equatable.dart';
import 'package:venues_app/src/models/image_model.dart';
import 'package:venues_app/src/models/venue_model.dart';

class SectionItemModel extends Equatable {
  final ImageModel image;
  final VenueModel? venue;
  final bool isFavorite;

  const SectionItemModel({
    required this.image,
    required this.venue,
    this.isFavorite = false,
  });

  factory SectionItemModel.fromJson(Map<String, dynamic> json) {
    return SectionItemModel(
        image: ImageModel.fromJson(json['image']),
        venue:
            json['venue'] != null ? VenueModel.fromJson(json['venue']) : null);
  }

  SectionItemModel copyWith({
    ImageModel? image,
    VenueModel? venue,
    bool? isFavorite,
  }) {
    return SectionItemModel(
      image: image ?? this.image,
      venue: venue ?? this.venue,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        image,
        venue,
        isFavorite,
      ];
}
