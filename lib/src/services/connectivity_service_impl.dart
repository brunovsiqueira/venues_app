import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:venues_app/src/services/interfaces/connectivity_service.dart';
import 'package:venues_app/src/services/interfaces/logger_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final LoggerService _loggerService;

  ConnectivityServiceImpl(this._loggerService);

  @override
  Future<bool> isConnected() async {
    try {
      return await InternetConnectionChecker().hasConnection;
    } catch (e, stackTrace) {
      _loggerService.logException(exception: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
