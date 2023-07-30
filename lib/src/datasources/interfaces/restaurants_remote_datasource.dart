import 'package:venues_app/src/models/restaurants_response_model.dart';

abstract interface class RestaurantsRemoteDatasource {
  Future<RestaurantsResponseModel> getRestaurants({
    required double lat,
    required double long,
  });
}
