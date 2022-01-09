import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:bingo_fe/services/api/api_client.dart';
import 'package:bingo_fe/services/api/api_service.dart';
import 'package:bingo_fe/services/cache/cache_service.dart';

GetIt it = GetIt.instance;

Future<void> registerServices() async{

  final apiClient = ApiClient(basePath: "http://127.0.0.1:8080");
  const cacheClient = FlutterSecureStorage();

  it.registerLazySingleton(() => ApiService(client: apiClient));
  it.registerLazySingleton(() => CacheService(client: cacheClient));
}