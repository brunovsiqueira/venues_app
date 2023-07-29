import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

class ServerException extends Equatable implements Exception {
  final DioException dioException;
  final String? customMessage;
  final Level? customLevel;

  const ServerException({
    required this.dioException,
    this.customMessage,
    this.customLevel,
  });

  @override
  List<Object?> get props => [dioException, customMessage, customMessage];
}
