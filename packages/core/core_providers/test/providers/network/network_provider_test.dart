import 'package:core_providers/core_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_provider_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  group('NetworkInfoProvider Tests', () {
    late InternetConnectionChecker internetConnectionChecker;
    late ProviderContainer container;

    setUp(() {
      internetConnectionChecker = MockInternetConnectionChecker();
      container = ProviderContainer(
        overrides: [
          internetConnectionCheckerProvider
              .overrideWithValue(internetConnectionChecker),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should return true when there is an internet connection', () async {
      // Arrange
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      // Act
      final networkInfo = container.read(networkInfoProvider);
      final hasConnection = await networkInfo.isConnected;

      // Assert
      expect(hasConnection, true);
    });

    test('should return false when there is no internet connection', () async {
      // Arrange
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => false);

      // Act
      final networkInfo = container.read(networkInfoProvider);
      final hasConnection = await networkInfo.isConnected;

      // Assert
      expect(hasConnection, false);
    });
  });
}
