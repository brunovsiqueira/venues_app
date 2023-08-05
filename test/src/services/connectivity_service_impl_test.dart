import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:venues_app/src/services/connectivity_service_impl.dart';
import 'package:venues_app/src/services/interfaces/logger_service.dart';

class MockLoggerService extends Mock implements LoggerService {}

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  final mockLoggerService = MockLoggerService();
  final mockConnectionChecker = MockInternetConnectionChecker();
  final service =
      ConnectivityServiceImpl(mockLoggerService, mockConnectionChecker);

  setUp(() {
    when(() => mockLoggerService.logException(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'))).thenAnswer((_) async {
      return;
    });
  });

  void setUpSuccessfulConnectionCheck() {
    when(() => mockConnectionChecker.hasConnection)
        .thenAnswer((_) async => true);
  }

  void setUpFailedConnectionCheck() {
    when(() => mockConnectionChecker.hasConnection)
        .thenAnswer((_) async => false);
  }

  test(
      'should call InternetConnectionChecker and return true on successful connection check',
      () async {
    // Arrange
    setUpSuccessfulConnectionCheck();

    // Act
    final result = await service.isConnected();

    // Assert
    expect(result, true);
  });

  test(
      'should call InternetConnectionChecker and return false on failed connection check',
      () async {
    // Arrange
    setUpFailedConnectionCheck();

    // Act
    final result = await service.isConnected();

    // Assert
    expect(result, false);
  });

  test('should call logger service and rethrow on exception', () async {
    // Arrange
    when(() => mockConnectionChecker.hasConnection).thenThrow(Exception());

    // Act
    final call = service.isConnected;

    // Assert
    expect(
      () async => await call(),
      throwsA(isA<Exception>()),
    );
    verify(() => mockLoggerService.logException(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'))).called(1);
  });
}
