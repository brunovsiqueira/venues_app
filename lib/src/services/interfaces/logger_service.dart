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
}
