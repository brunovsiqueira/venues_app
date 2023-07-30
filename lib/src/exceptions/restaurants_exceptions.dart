// ignore_for_file: must_be_immutable

import 'package:venues_app/src/exceptions/base/server_exception.dart';

class GetRestaurantsException extends ServerException {
  GetRestaurantsException({
    required super.dioException,
    required super.stackTrace,
    super.message = 'Error getting restaurants. Try again later.',
  });
}
