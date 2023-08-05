import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/controllers/favorite_restaurants_controller.dart';

final favoriteRestaurantsControllerProvider =
    Provider<FavoriteRestaurantsController>((ref) {
  return FavoriteRestaurantsController();
});
