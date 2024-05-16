import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:pokedex/app/presentation/home/home_page.dart';
import 'package:pokedex/app/presentation/home/notifiers/home_notifier.dart';
import 'package:pokedex/core/providers/network_provider.dart';
import 'package:pokedex/core/providers/storage_provider.dart';
import 'package:pokedex/main.dart';
import 'package:pokedex/observers.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> waitForPokemonList(
  WidgetTester tester,
  BuildContext context, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final endTime = DateTime.now().add(timeout);
  while (!await isPokemonListNotEmpty(tester)) {
    if (DateTime.now().isAfter(endTime)) {
      throw Exception('Timeout waiting');
    }
    await tester.pumpAndSettle();
  }
}

Future<bool> isPokemonListNotEmpty(
  WidgetTester tester,
) async {
  final ref = tester.element<ConsumerStatefulElement>(find.byType(HomePage));
  final homeState = ref.watch(homeNotifierProvider);
  return homeState.pokemonList.isNotEmpty;
}

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  final internetConnectionChecker = InternetConnectionChecker.createInstance();
  const flutterSecureStorage = FlutterSecureStorage();

  testWidgets('home page end-to-end test', (tester) async {
    await mockNetworkImages(
      () async => tester.pumpWidget(
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
          child: const MyApp(),
        ),
      ),
    );

    expect(find.byType(HomePage), findsOneWidget);
    final context = tester.element(find.byType(HomePage));

    await waitForPokemonList(tester, context);

    final ref = tester.element(find.byType(HomePage)) as WidgetRef;
    final homeState = ref.watch(homeNotifierProvider);

    expect(homeState.pokemonList, isNotEmpty);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });
}
