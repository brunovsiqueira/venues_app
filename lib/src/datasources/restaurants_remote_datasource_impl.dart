import 'package:dio/dio.dart';
import 'package:venues_app/src/exceptions/restaurants_exceptions.dart';
import 'package:venues_app/src/exceptions/unmapped_exception.dart';
import 'package:venues_app/src/models/restaurants_response_model.dart';
import 'package:venues_app/src/network/interfaces/api.dart';

import 'interfaces/restaurants_remote_datasource.dart';

class RestaurantsRemoteDatasourceImpl implements RestaurantsRemoteDatasource {
  final API _api;
  final String _baseUrl;

  RestaurantsRemoteDatasourceImpl(this._api, this._baseUrl);

  @override
  Future<RestaurantsResponseModel> getRestaurants({
    required double lat,
    required double long,
  }) async {
    final String url = '$_baseUrl/v1/pages/restaurants';
    final queryParams = {'lat': lat, 'long': long};
    try {
      Response response =
          await _api.httpGet(url: url, queryParams: queryParams);
      return RestaurantsResponseModel.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      throw GetRestaurantsException(dioException: e, stackTrace: stackTrace);
    } catch (e, stackTrace) {
      throw UnmappedException(exception: e, stackTrace: stackTrace);
    }
  }
}
