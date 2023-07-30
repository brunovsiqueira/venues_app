import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';

abstract interface class RestaurantsService {
  Future<RestaurantsResponseModel> getRestaurants({
    required CoordinatesModel coordinates,
  });
}
