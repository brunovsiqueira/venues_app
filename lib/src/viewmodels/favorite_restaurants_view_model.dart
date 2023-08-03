import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRestaurantsController {
  final String favoriteRestaurantsIdsKey = 'favorite_restaurants_ids';

  List<String> favoriteRestaurantsIds = [];

  SharedPreferences? prefs;

  Future<void> initializeFavoriteRestaurantsIds() async {
    prefs = await SharedPreferences.getInstance();
    favoriteRestaurantsIds =
        prefs?.getStringList(favoriteRestaurantsIdsKey) ?? [];
  }

  Future<void> writeFavoriteRestaurantId(String restaurantId) async {
    await prefs
        ?.setStringList(favoriteRestaurantsIdsKey, <String>[restaurantId]);
  }
}
