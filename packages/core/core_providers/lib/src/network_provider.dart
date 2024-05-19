import 'package:core_providers/src/network/network_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final internetConnectionCheckerProvider =
    Provider<InternetConnectionChecker>((ref) {
  return InternetConnectionChecker();
});

// Provider for NetworkInfo
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(ref.read(internetConnectionCheckerProvider));
});
