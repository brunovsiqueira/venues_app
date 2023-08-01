import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/providers/restaurants_coordinates_provider.dart';
import 'package:venues_app/src/providers/restaurants_service_provider.dart';

// final restaurantsTimerProvider = Provider<Timer>((ref) {
//   int locationIndex = 0;
//   return Timer.periodic(Duration(seconds: 10), (timer) {
//     final CoordinatesModel currentCoordinate = locations[locationIndex];
//     // Refresh the venue list provider with the updated location
//     ref.refresh(
//         restaurantsProvider(currentCoordinate));

//     locationIndex = (locationIndex + 1) % locations.length;
//   });
// });

final restaurantsProvider =
    FutureProvider.family<RestaurantsResponseModel, CoordinatesModel>(
        (ref, coordinates) async {
  print('provider coordinate: ${coordinates.toQueryParams()}');
  // ref.listen(restaurantCoordinatesProvider, (previous, next) {
  //   if ()
  //  });
  return ref
      .read(restaurantsServiceProvider)
      .getRestaurants(coordinates: coordinates);
});
