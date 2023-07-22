import 'package:venues_app/src/models/image_model.dart';
import 'package:venues_app/src/models/venue_model.dart';

class SectionItemModel {
  final ImageModel image;
  final VenueModel venue;

  SectionItemModel({
    required this.image,
    required this.venue,
  });

  factory SectionItemModel.fromJson(Map<String, dynamic> json) {
    return SectionItemModel(
        image: ImageModel.fromJson(json['image']),
        venue: VenueModel.fromJson(json['venue']));
  }
}
