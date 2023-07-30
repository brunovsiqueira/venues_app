// ignore_for_file: must_be_immutable

import 'package:venues_app/src/exceptions/base/base_exception.dart';

class UnmappedException extends BaseException {
  final dynamic exception;

  UnmappedException({
    required this.exception,
    required super.stackTrace,
    super.message = 'An unexpected error occurred. Try again later',
    super.level,
  });

  @override
  List<Object?> get props => [message, stackTrace, level, exception];
}
