import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venues_app/src/services/interfaces/logger_service.dart';
import 'package:venues_app/src/services/logger_service_impl.dart';

final loggerServiceProvider = Provider<LoggerService>((ref) {
  return LoggerServiceImpl();
});
