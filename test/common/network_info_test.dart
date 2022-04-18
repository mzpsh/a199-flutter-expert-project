import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:ditonton/common/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  test('should be able to return an accurate connection status', () async {
    // arrange
    final mockDataConnectionChecker = MockDataConnectionChecker();
    when(() => mockDataConnectionChecker.hasConnection)
        .thenAnswer((_) async => true);
    // act
    final networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
    final hasConnection = await networkInfo.isConnected;
    // assert
    expect(hasConnection, true);
  });
}
