import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/core/providers/storage_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_provider_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group('SharedPreferencesProvider Tests', () {
    late SharedPreferences mockSharedPreferences;
    late ProviderContainer container;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      when(mockSharedPreferences.getString(any)).thenReturn('testValue');
      container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
      ]);
    });

    tearDown(() {
      container.dispose();
    });

    test('should write and read a value', () async {
      // Write value
      expect(
          await container
              .read(sharedPreferencesProvider)
              .setString('key', 'value'),
          true);

      // Read value
      final readValue =
          container.read(sharedPreferencesProvider).getString('key');
      expect(readValue, 'testValue');

      verify(mockSharedPreferences.setString('key', 'value')).called(1);
      verify(mockSharedPreferences.getString('key')).called(1);
    });
  });
}
