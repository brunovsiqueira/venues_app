import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/src/datasources/interfaces/restaurants_remote_datasource.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/services/interfaces/logger_service.dart';
import 'package:venues_app/src/services/restaurants_service_impl.dart';

import '../../fixtures/fixture_reader.dart';

class MockRestaurantsRemoteDatasource extends Mock
    implements RestaurantsRemoteDatasource {}

class MockLoggerService extends Mock implements LoggerService {}

void main() {
  final mockRemoteDatasource = MockRestaurantsRemoteDatasource();
  final mockLoggerService = MockLoggerService();
  final service =
      RestaurantsServiceImpl(mockRemoteDatasource, mockLoggerService);

  const coordinates = CoordinatesModel(latitude: 0.0, longitude: 0.0);

  final Map<String, dynamic> jsonMap =
      jsonDecode(fixture('restaurants_response.json'));

  final successfulResponse = RestaurantsResponseModel.fromJson(jsonMap);

  setUpAll(() {
    registerFallbackValue(coordinates);
  });

  setUp(() {
    when(() => mockLoggerService.logException(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'))).thenAnswer((_) async {
      return;
    });
  });

  void setUpSuccessfulRemoteCall() {
    when(() => mockRemoteDatasource.getRestaurants(
            coordinates: any(named: 'coordinates')))
        .thenAnswer((_) async => successfulResponse);
  }

  void setUpRemoteException() {
    when(() => mockRemoteDatasource.getRestaurants(
        coordinates: any(named: 'coordinates'))).thenThrow(Exception());
  }

  test(
      'should call remote datasource and return RestaurantsResponseModel on success',
      () async {
    // Arrange
    setUpSuccessfulRemoteCall();

    // Act
    final result = await service.getRestaurants(coordinates: coordinates);

    // Assert
    expect(result, equals(successfulResponse));
  });

  test('should call LoggerService and rethrow on exception', () async {
// Arrange
    setUpRemoteException();

    // Act
    final call = service.getRestaurants;

    // Assert
    expect(
      () async => await call(coordinates: coordinates),
      throwsA(isA<Exception>()),
    );
    verify(() => mockLoggerService.logException(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'))).called(1);
  });
}
