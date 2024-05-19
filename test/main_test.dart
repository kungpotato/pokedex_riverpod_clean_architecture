import 'package:core_providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/observers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_test.mocks.dart';

@GenerateMocks(
  [SharedPreferences, InternetConnectionChecker, FlutterSecureStorage],
)
void main() {
  testWidgets('MyApp builds correctly', (WidgetTester tester) async {
    final sharedPreferences = MockSharedPreferences();
    final internetConnectionChecker = MockInternetConnectionChecker();
    final flutterSecureStorage = MockFlutterSecureStorage();

    await tester.pumpWidget(
      ProviderScope(
        observers: [
          Observers(),
        ],
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          internetConnectionCheckerProvider
              .overrideWithValue(internetConnectionChecker),
          secureStorageProvider.overrideWithValue(flutterSecureStorage),
        ],
        child: const MyApp(
          home: SizedBox(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(MyApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
