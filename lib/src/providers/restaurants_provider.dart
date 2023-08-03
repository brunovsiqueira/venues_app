import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/providers/favorite_restaurants_provider.dart';
import 'package:venues_app/src/providers/restaurants_service_provider.dart';

final restaurantsProvider =
    FutureProvider.family<RestaurantsResponseModel, CoordinatesModel>(
        (ref, coordinates) async {
  print('provider coordinate: ${coordinates.toQueryParams()}');
  await ref
      .read(favoriteRestaurantsControllerProvider)
      .initializeFavoriteRestaurantsIds();
  //TODO: pass favorites by parameter to getRestaurants?
  return ref
      .read(restaurantsServiceProvider)
      .getRestaurants(coordinates: coordinates);
});
