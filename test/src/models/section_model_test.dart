import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/src/models/image_model.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/models/section_model.dart';
import 'package:venues_app/src/models/venue_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid SectionModel with items', () {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('restaurant_section.json'));

      const sectionModel = SectionModel(
        items: [
          SectionItemModel(
            image: ImageModel(
              blurhash: "jjTYCHru;;DcT;qIh5plTaKBcPBk",
              url:
                  "https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png",
            ),
            venue: VenueModel(
              id: "5ae6013cf78b5a000bb64022",
              name: "McDonald's Helsinki Kamppi",
              shortDescription: "I'm lovin' it.",
              distance: "100 m",
              score: 8.2,
              deliveryPrice: "€0.00",
              estimateRange: "5-15",
            ),
            isFavorite: false,
          ),
          // More items...
        ],
        title: "All restaurants",
        name: "restaurants-delivering-venues",
      );

      // Act
      final result = SectionModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(sectionModel));
    });

    test('should return a valid SectionModel without items', () {
      // Arrange
      final jsonMap = {
        "items": null,
        "title": "Section Title",
        "name": "section_name"
      };

      const sectionModel = SectionModel(
        items: [],
        title: "Section Title",
        name: "section_name",
      );

      // Act
      final result = SectionModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(sectionModel));
    });
  });
}
