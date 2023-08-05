import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:venues_app/src/models/venue_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  group('fromJson', () {
    test('should return a valid VenueModel', () {
      // Arrange
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('restaurant_venue_item.json'));

      const venue = VenueModel(
        id: "5ae6013cf78b5a000bb64022",
        name: "McDonald's Helsinki Kamppi",
        shortDescription: "I'm lovin' it.",
        distance: "100 m",
        score: 8.2,
        deliveryPrice: "€0.00",
        estimateRange: "5-15",
      );

      // Act
      final result = VenueModel.fromJson(jsonMap);

      // Assert
      expect(result, equals(venue));
    });
  });
}
