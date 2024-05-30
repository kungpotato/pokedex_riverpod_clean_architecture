import 'dart:convert';

import 'package:auth/auth.dart';
import 'package:core_providers/core_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:home/home.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pokedex/firebase_options.dart';
import 'package:pokedex/observers.dart';
import 'package:pokedex/service/rmc_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  final internetConnectionChecker = InternetConnectionChecker.createInstance();
  const flutterSecureStorage = FlutterSecureStorage();

  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ),
  );
  await remoteConfig.fetchAndActivate();
  final remoteConfigService = RemoteConfigService(remoteConfig);

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
      child: MyApp(
        home: const HomePage(),
        remoteConfigService: remoteConfigService,
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({required this.home, this.remoteConfigService, super.key});

  final Widget home;
  final RemoteConfigService? remoteConfigService;

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final json = widget.remoteConfigService?.getJson();
      final val = json?['app_home'] as RemoteConfigValue;
      final test = jsonDecode(val.asString()) as Map<String, dynamic>;
      print(test);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: authState.when(
        data: (data) => data.user != null ? widget.home : const LoginPage(),
        error: (error, stackTrace) => const Text('error'),
        loading: CircularProgressIndicator.new,
      ),
    );
  }
}
