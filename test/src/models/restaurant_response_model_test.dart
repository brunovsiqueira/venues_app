import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/src/models/image_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/models/section_item_model.dart';
import 'package:venues_app/src/models/section_model.dart';
import 'package:venues_app/src/models/venue_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
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
    ],
    title: "All restaurants",
    name: "restaurants-delivering-venues",
  );
  group('fromJson', () {
    test('should return a valid RestaurantsResponseModel', () {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('restaurants_response.json'));

      const restaurantsResponseModel = RestaurantsResponseModel(
        pageTitle: "Restaurants",
        sections: [sectionModel],
      );

      // Act
      final result = RestaurantsResponseModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(restaurantsResponseModel));
    });
  });

  group('deliveringRestaurantsSection', () {
    test('should return the delivering restaurants section', () {
      // Arrange
      const sections = [
        SectionModel(
          items: [
            // Section item attributes...
          ],
          title: "Section Title",
          name: "restaurants-delivering-venues",
        ),
        SectionModel(
          items: [
            // Section item attributes...
          ],
          title: "Another Section Title",
          name: "another-section-name",
        ),
        // More sections...
      ];

      const restaurantsResponseModel = RestaurantsResponseModel(
        pageTitle: "Page Title",
        sections: sections,
      );

      final expectedDeliveringSection = sections[0];

      // Act
      final result = restaurantsResponseModel.deliveringRestaurantsSection;

      // Assert
      expect(result, equals(expectedDeliveringSection));
    });

    test('should return null if delivering restaurants section not found', () {
      // Arrange
      const sections = [
        SectionModel(
          items: [
            // Section item attributes...
          ],
          title: "Section Title",
          name: "another-section-name",
        ),
        // More sections...
      ];

      const restaurantsResponseModel = RestaurantsResponseModel(
        pageTitle: "Page Title",
        sections: sections,
      );

      // Act
      final result = restaurantsResponseModel.deliveringRestaurantsSection;

      // Assert
      expect(result, isNull);
    });
  });

  group('props', () {
    test('should return correct list of properties', () {
      // Arrange
      const restaurantsResponseModel = RestaurantsResponseModel(
        pageTitle: "Page Title",
        sections: [
          SectionModel(
            items: [
              // Section item attributes...
            ],
            title: "Section Title",
            name: "restaurants-delivering-venues",
          ),
          // More sections...
        ],
      );

      // Act & Assert
      expect(
        restaurantsResponseModel.props,
        [restaurantsResponseModel.pageTitle, restaurantsResponseModel.sections],
      );
    });
  });
}
