import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/coordinates_model.dart';

class RestaurantCoordinatesViewModel extends StateNotifier<CoordinatesModel> {
  final List<CoordinatesModel> coordinatesList;

  RestaurantCoordinatesViewModel(
    this.coordinatesList,
  ) : super(CoordinatesModel(
            latitude: coordinatesList[0].latitude,
            longitude: coordinatesList[0].longitude));

  int _locationIndex = 0;
  @visibleForTesting
  Timer? timer;

  void startLocationTimer() {
    timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _locationIndex = (_locationIndex + 1) % coordinatesList.length;
      final currentLocation = coordinatesList[_locationIndex];
      state = CoordinatesModel(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
