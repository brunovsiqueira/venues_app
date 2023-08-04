import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/viewmodels/restaurant_coordinates_view_model.dart';

final restaurantCoordinatesProvider = StateNotifierProvider.autoDispose<
    RestaurantCoordinatesViewModel, CoordinatesModel>((ref) {
  final restaurantCoordinatesViewModel = RestaurantCoordinatesViewModel(
    [
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
    ],
  );
  restaurantCoordinatesViewModel.startLocationTimer();
  return restaurantCoordinatesViewModel;
  //FIXME: only send 10, doesnt go to the first
});
