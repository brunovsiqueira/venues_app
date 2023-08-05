import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/src/models/image_model.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/models/venue_model.dart';

import '../../fixtures/fixture_reader.dart'; // Import the correct package path

void main() {
  group('fromJson', () {
    test('should return a valid SectionItemModel with venue', () {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('restaurant_section_item.json'));

      const sectionItem = SectionItemModel(
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
      );

      // Act
      final result = SectionItemModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(sectionItem));
    });

    test('should return a valid SectionItemModel without venue', () {
      // Arrange
      final jsonMap = {
        "image": {
          "blurhash": "jjTYCHru;;DcT;qIh5plTaKBcPBk",
          "url":
              "https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png"
        },
        "venue": null
      };

      const sectionItem = SectionItemModel(
        image: ImageModel(
          blurhash: "jjTYCHru;;DcT;qIh5plTaKBcPBk",
          url:
              "https://prod-wolt-venue-images-cdn.wolt.com/5ae6013cf78b5a000bb64022/bc80c9c4-9ead-11eb-9441-4efedaea1730_mcd_wolt_etusivu_1010x544.png",
        ),
        venue: null,
      );

      // Act
      final result = SectionItemModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(sectionItem));
    });
  });

  group('copyWith', () {
    test('should return a new SectionItemModel with updated image', () {
      // Arrange
      const initialSectionItem = SectionItemModel(
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
      );

      const updatedImage = ImageModel(
        blurhash: "new_blurhash",
        url: "new_image_url.png",
      );

      final expectedSectionItem =
          initialSectionItem.copyWith(image: updatedImage);

      // Act
      final result = initialSectionItem.copyWith(image: updatedImage);

      // Assert
      expect(result, equals(expectedSectionItem));
    });

    test('should return a new SectionItemModel with updated venue', () {
      // Arrange
      const initialSectionItem = SectionItemModel(
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
      );

      const updatedVenue = VenueModel(
        id: "new_id",
        name: "New Venue",
        shortDescription: "New short description",
        distance: "200 m",
        score: 9.0,
        deliveryPrice: "€2.00",
        estimateRange: "10-20",
      );

      final expectedSectionItem =
          initialSectionItem.copyWith(venue: updatedVenue);

      // Act
      final result = initialSectionItem.copyWith(venue: updatedVenue);

      // Assert
      expect(result, equals(expectedSectionItem));
    });

    test('should return a new SectionItemModel with updated isFavorite', () {
      // Arrange
      const initialSectionItem = SectionItemModel(
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
      );

      final expectedSectionItem = initialSectionItem.copyWith(isFavorite: true);

      // Act
      final result = initialSectionItem.copyWith(isFavorite: true);

      // Assert
      expect(result, equals(expectedSectionItem));
    });
  });
}
