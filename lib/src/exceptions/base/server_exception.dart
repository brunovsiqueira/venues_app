// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:venues_app/src/exceptions/base/base_exception.dart';

class ServerException extends BaseException {
  final DioException dioException;

  ServerException({
    required this.dioException,
    required super.stackTrace,
    required super.message,
    super.level,
  }) {
    if (dioException
        case DioException(response: Response(statusCode: int statusCode))
        when statusCode >= 500 && statusCode < 600) {
      level = Level.SEVERE;
    } else {
      level = Level.WARNING;
    }
  }

  @override
  List<Object?> get props => [message, stackTrace, level, dioException];
}
