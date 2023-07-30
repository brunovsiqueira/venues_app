import 'package:venues_app/src/datasources/interfaces/restaurants_remote_datasource.dart';
import 'package:venues_app/src/models/coordinates_model.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/services/interfaces/logger_service.dart';
import 'package:venues_app/src/services/interfaces/restaurants_service.dart';

class RestaurantsServiceImpl implements RestaurantsService {
  final RestaurantsRemoteDatasource _restaurantsRemoteDatasource;
  final LoggerService _loggerService;

  RestaurantsServiceImpl(
      this._restaurantsRemoteDatasource, this._loggerService);

  @override
  Future<RestaurantsResponseModel> getRestaurants({
    required CoordinatesModel coordinates,
  }) async {
    try {
      return await _restaurantsRemoteDatasource.getRestaurants(
          coordinates: coordinates);
    } catch (e, stackTrace) {
      _loggerService.logException(exception: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
