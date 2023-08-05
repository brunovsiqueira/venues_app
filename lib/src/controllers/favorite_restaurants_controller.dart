import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRestaurantsController {
  final String favoriteRestaurantsIdsKey = 'favorite_restaurants_ids';

  List<String> favoriteRestaurantsIds = [];

  late final Future<SharedPreferences> _sharedPreferences;

  FavoriteRestaurantsController() {
    _sharedPreferences = SharedPreferences.getInstance();
  }

  Future<void> initializeFavoriteRestaurantsIds() async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    favoriteRestaurantsIds =
        sharedPreferences.getStringList(favoriteRestaurantsIdsKey) ?? [];
  }

  Future<void> addFavoriteRestaurantId(String restaurantId) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    favoriteRestaurantsIds.add(restaurantId);
    await sharedPreferences.setStringList(
        favoriteRestaurantsIdsKey, favoriteRestaurantsIds);
  }

  Future<void> removeFavoriteRestaurantId(String restaurantId) async {
    SharedPreferences sharedPreferences = await _sharedPreferences;
    favoriteRestaurantsIds.remove(restaurantId);
    await sharedPreferences.setStringList(
        favoriteRestaurantsIdsKey, favoriteRestaurantsIds);
  }
}
