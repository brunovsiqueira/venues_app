import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/src/datasources/restaurants_remote_datasource_impl.dart';
import 'package:venues_app/src/exceptions/restaurants_exceptions.dart';
import 'package:venues_app/src/exceptions/unmapped_exception.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/network/interfaces/api.dart';

import '../../fixtures/fixture_reader.dart';

class MockAPI extends Mock implements API {}

void main() {
  final mockAPI = MockAPI();
  const baseUrl = 'https://restaurant-api.wolt.com';
  final datasource = RestaurantsRemoteDatasourceImpl(mockAPI, baseUrl);

  group('getRestaurants', () {
    const coordinates = CoordinatesModel(latitude: 0.0, longitude: 0.0);
    final queryParams = coordinates.toQueryParams();
    const url = '$baseUrl/v1/pages/restaurants';

    final Map<String, dynamic> jsonMap =
        jsonDecode(fixture('restaurants_response.json'));

    final requestOptions = RequestOptions(path: url);

    final successfulResponse =
        Response(data: jsonMap, requestOptions: requestOptions);

    void setUpSuccessfulAPICall() {
      when(() => mockAPI.httpGet(
          url: any(named: 'url'),
          queryParams: any(named: 'queryParams'))).thenAnswer(
        (_) async => successfulResponse,
      );
    }

    void setUpUnsuccessfulAPICall() {
      when(() => mockAPI.httpGet(
          url: any(named: 'url'),
          queryParams: any(named: 'queryParams'))).thenThrow(DioException(
        requestOptions: requestOptions,
      ));
    }

    test('should perform a GET request on the URL', () async {
      // Arrange
      setUpSuccessfulAPICall();

      // Act
      await datasource.getRestaurants(coordinates: coordinates);

      // Assert
      verify(() => mockAPI.httpGet(url: url, queryParams: queryParams))
          .called(1);
    });

    test('should return RestaurantsResponseModel on successful API call',
        () async {
      // Arrange
      setUpSuccessfulAPICall();

      // Act
      final result = await datasource.getRestaurants(coordinates: coordinates);

      // Assert
      var expected = RestaurantsResponseModel.fromJson(jsonMap);

      expect(result, expected);
    });

    test('should throw GetRestaurantsException on DioException', () async {
      // Arrange
      setUpUnsuccessfulAPICall();

      // Act
      final call = datasource.getRestaurants;

      // Assert
      expect(
        () async => await call(coordinates: coordinates),
        throwsA(const TypeMatcher<GetRestaurantsException>()),
      );
    });

    test('should throw UnmappedException on other exceptions', () async {
      // Arrange
      when(() => mockAPI.httpGet(
          url: any(named: 'url'),
          queryParams: any(named: 'queryParams'))).thenThrow(Exception());

      // Act
      final call = datasource.getRestaurants;

      // Assert
      expect(
        () async => await call(coordinates: coordinates),
        throwsA(const TypeMatcher<UnmappedException>()),
      );
    });
  });
}
