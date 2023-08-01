import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/viewmodels/restaurant_coordinates_view_model.dart';

final restaurantCoordinatesProvider =
    StateNotifierProvider<RestaurantCoordinatesViewModel, CoordinatesModel>(
        (ref) {
  final restaurantCoordinatesViewModel = RestaurantCoordinatesViewModel();
  restaurantCoordinatesViewModel.startLocationTimer();
  return restaurantCoordinatesViewModel;
});
