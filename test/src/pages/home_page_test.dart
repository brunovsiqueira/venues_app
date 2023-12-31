import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/src/exceptions/base/base_exception.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/pages/home_page.dart';
import 'package:venues_app/src/providers/restaurants_provider.dart';
import 'package:venues_app/src/services/interfaces/restaurants_service.dart';

class MockWidgetRef extends Mock implements WidgetRef {}

class MockStackTrace extends Mock implements StackTrace {}

class MockRestaurantsService extends Mock implements RestaurantsService {}

void main() {
  const coordinates = CoordinatesModel(latitude: 62.20, longitude: 61.20);
  final mockRestaurantsService = MockRestaurantsService();
  const String exceptionMessage = 'message';

  // final Map<String, dynamic> jsonMap =
  //     jsonDecode(fixture('restaurants_response.json'));

  //final successfulResponse = RestaurantsResponseModel.fromJson(jsonMap);

  setUpAll(() {
    registerFallbackValue(coordinates);
  });

  // void setUpSuccessfulRemoteCall() {
  //   when(() => mockRestaurantsService.getRestaurants(
  //           coordinates: any(named: 'coordinates')))
  //       .thenAnswer((_) async => successfulResponse);
  // }

  void setUpRemoteException() {
    when(() =>
        mockRestaurantsService.getRestaurants(
            coordinates: any(named: 'coordinates'))).thenThrow(
        BaseException(message: exceptionMessage, stackTrace: MockStackTrace()));
  }

  testWidgets('HomePage shows CircularProgressIndicator while loading',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    // The loading indicator should be present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('HomePage shows error message when an error occurs',
      (WidgetTester tester) async {
    setUpRemoteException();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          restaurantsProvider.overrideWith((ref, arg) =>
              mockRestaurantsService.getRestaurants(coordinates: coordinates))
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      ),
    );

    expect(find.text(exceptionMessage), findsOneWidget);
  });
}
