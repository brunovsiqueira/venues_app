import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/datasources/restaurants_remote_datasource_impl.dart';
import 'package:venues_app/src/providers/api_provider.dart';
import 'package:venues_app/src/providers/logger_service_provider.dart';
import 'package:venues_app/src/services/interfaces/restaurants_service.dart';
import 'package:venues_app/src/services/restaurants_service_impl.dart';

final restaurantsServiceProvider = Provider<RestaurantsService>((ref) {
  return RestaurantsServiceImpl(
      RestaurantsRemoteDatasourceImpl(
        ref.read(apiProvider),
        dotenv.env['RESTAURANTS_API_URL']!,
      ),
      ref.read(loggerServiceProvider));
});
