// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

class BaseException extends Equatable implements Exception {
  final String message;
  final StackTrace stackTrace;
  Level? level;

  BaseException({
    required this.stackTrace,
    required this.message,
    this.level,
  });

  @override
  List<Object?> get props => [
        message,
        stackTrace,
        level,
      ];
}
