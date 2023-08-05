// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/viewmodels/restaurant_coordinates_view_model.dart';

class FakeTimer implements Timer {
  bool _isActive = true;

  @override
  bool get isActive => _isActive;

  @override
  void cancel() {
    _isActive = false;
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockRestaurantCoordinatesViewModel extends Mock
    implements RestaurantCoordinatesViewModel {}

void main() {
  final mockCoordinatesList = List.generate(
    3,
    (index) => CoordinatesModel(
        latitude: index.toDouble(), longitude: index.toDouble()),
  );

  late RestaurantCoordinatesViewModel viewModel;

  setUp(() {
    viewModel = RestaurantCoordinatesViewModel(mockCoordinatesList);
  });

  test('initial state should match first item in coordinatesList', () {
    expect(
      viewModel.state.latitude,
      mockCoordinatesList[0].latitude,
    );
    expect(
      viewModel.state.longitude,
      mockCoordinatesList[0].longitude,
    );
  });

  test(
      'startLocationTimer should update state with different coordinates over time',
      () {
    final fakeTimer = FakeTimer();
    viewModel.timer = fakeTimer;

    viewModel.startLocationTimer();

    final expectedStates =
        mockCoordinatesList.map((coordinates) => coordinates).toList();
    int stateChangeCount = 0;

    viewModel.addListener((state) {
      expect(state.latitude, expectedStates[stateChangeCount].latitude);
      expect(state.longitude, expectedStates[stateChangeCount].longitude);
      stateChangeCount++;
      if (stateChangeCount == expectedStates.length) {
        viewModel.dispose();
        fakeTimer.cancel();
      }
    });
  });

  test('dispose should cancel the timer', () {
    final fakeTimer = FakeTimer();
    viewModel.timer = fakeTimer;

    viewModel.dispose();
    expect(fakeTimer.isActive, false);
  });
}
