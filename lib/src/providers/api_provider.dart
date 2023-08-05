import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:venues_app/src/network/api_impl.dart';
import 'package:venues_app/src/network/interfaces/api.dart';
import 'package:venues_app/src/providers/logger_service_provider.dart';
import 'package:venues_app/src/services/connectivity_service_impl.dart';

final apiProvider = Provider<API>((ref) {
  return APIImpl(
    headersBuilders: {},
    dio: Dio(),
    connectivityService: ConnectivityServiceImpl(
      ref.read(loggerServiceProvider),
      InternetConnectionChecker(),
    ),
  );
});
