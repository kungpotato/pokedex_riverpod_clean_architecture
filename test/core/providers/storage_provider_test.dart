import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/core/providers/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_provider_test.mocks.dart';

@GenerateMocks([SharedPreferences, FlutterSecureStorage])
void main() {
  group('SharedPreferencesProvider Tests', () {
    late SharedPreferences mockSharedPreferences;
    late ProviderContainer container;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.setString('test1', 'ok'))
          .thenAnswer((_) async => true);
      when(mockSharedPreferences.getString('test1')).thenReturn('ok');
      container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should write and read a value', () async {
      // Write value
      expect(
        await container
            .read(sharedPreferencesProvider)
            .setString('test1', 'ok'),
        true,
      );

      // Read value
      final readValue =
          container.read(sharedPreferencesProvider).getString('test1');
      expect(readValue, 'ok');

      verify(mockSharedPreferences.setString('test1', 'ok')).called(1);
      verify(mockSharedPreferences.getString('test1')).called(1);
    });

    test('should provide an instance of FlutterSecureStorage', () {
      // Act
      final secureStorage = container.read(secureStorageProvider);

      // Assert
      expect(secureStorage, isA<FlutterSecureStorage>());
    });

    test('should allow setting and getting values', () async {
      // Arrange
      final mockSecureStorage = MockFlutterSecureStorage();
      when(
        mockSecureStorage.write(key: anyNamed('key'), value: anyNamed('value')),
      ).thenAnswer((_) async => {});
      when(mockSecureStorage.read(key: anyNamed('key')))
          .thenAnswer((_) async => 'value');
      final container = ProviderContainer(
        overrides: [
          secureStorageProvider.overrideWithValue(mockSecureStorage),
        ],
      );

      // Act
      await container
          .read(secureStorageProvider)
          .write(key: 'testKey', value: 'testValue');
      final result =
          await container.read(secureStorageProvider).read(key: 'testKey');

      // Assert
      expect(result, equals('value'));
      verify(mockSecureStorage.write(key: 'testKey', value: 'testValue'))
          .called(1);
      verify(mockSecureStorage.read(key: 'testKey')).called(1);
    });
  });
}
