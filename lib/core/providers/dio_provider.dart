import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final BaseOptions options =
      BaseOptions(baseUrl: 'https://yourapi.domain.com');

  final Dio dio = Dio(options);

  // Optionally add interceptors to the Dio instance
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
});
