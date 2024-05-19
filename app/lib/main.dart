import 'package:core_providers/core_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokedex/observers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final internetConnectionChecker = InternetConnectionChecker.createInstance();
  const flutterSecureStorage = FlutterSecureStorage();

  runApp(
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
      child: const MyApp(home: HomePage()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({required this.home, super.key});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home,
    );
  }
}
