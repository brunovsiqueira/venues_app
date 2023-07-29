import 'package:logging/src/level.dart';
import 'package:venues_app/src/services/interfaces/logger_service.dart';

class LoggerServiceImpl implements LoggerService {
  @override
  Future<void> initialize(
      {required String clientToken, required String environment}) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<void> log(
      {required Level level,
      required String message,
      StackTrace? stackTrace,
      Exception? exception,
      Map<String, dynamic>? extraAttributes}) {
    // TODO: implement log
    throw UnimplementedError();
  }

  @override
  Future<void> logException(
      {required dynamic exception,
      String? message,
      Level? level,
      StackTrace? stackTrace,
      Map<String, dynamic>? extraAttributes}) {
    // TODO: implement logException
    throw UnimplementedError();
  }
}
