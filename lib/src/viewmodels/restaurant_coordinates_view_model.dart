import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/coordinates_model.dart';

final locations = [
  const CoordinatesModel(latitude: 60.170187, longitude: 24.930599),
  const CoordinatesModel(latitude: 60.169418, longitude: 24.931618),
  const CoordinatesModel(latitude: 60.169818, longitude: 24.932906),
  const CoordinatesModel(latitude: 60.170005, longitude: 24.935105),
  const CoordinatesModel(latitude: 60.169108, longitude: 24.936210),
  const CoordinatesModel(latitude: 60.168355, longitude: 24.934869),
  const CoordinatesModel(latitude: 60.167560, longitude: 24.932562),
  const CoordinatesModel(latitude: 60.168254, longitude: 24.931532),
  const CoordinatesModel(latitude: 60.169012, longitude: 24.930341),
  const CoordinatesModel(latitude: 60.170085, longitude: 24.929569),
]; //TODO: PASS list by argument

class RestaurantCoordinatesViewModel extends StateNotifier<CoordinatesModel> {
  RestaurantCoordinatesViewModel()
      : super(CoordinatesModel(
            latitude: locations[0].latitude,
            longitude: locations[0].longitude));

  int _locationIndex = 0;
  Timer? _timer;

  void startLocationTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _locationIndex = (_locationIndex + 1) % locations.length;
      final currentLocation = locations[_locationIndex];
      state = CoordinatesModel(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
