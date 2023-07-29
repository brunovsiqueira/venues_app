import 'package:logging/logging.dart';

abstract interface class LoggerService {
  Future<void> initialize({
    required String clientToken,
    required String environment,
  });

  Future<void> log(
      {required Level level,
      required String message,
      StackTrace? stackTrace,
      Exception? exception,
      Map<String, dynamic>? extraAttributes});

  Future<void> logException(
      {required dynamic exception,
      String? message,
      Level? level,
      StackTrace? stackTrace,
      Map<String, dynamic>? extraAttributes});
}
