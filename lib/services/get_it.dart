import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:bingo_fe/services/api/api_client.dart';
import 'package:bingo_fe/services/api/api_service.dart';
import 'package:bingo_fe/services/cache/cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [registerServices] is the method that, thanks to [GetIt] a ServiceLocator,
/// registers the Singletons instances for API and CACHE services.
/// It's called once before starting the app.
///
/// [it.registerLazySingleton] permits to create the service only if
/// it's called at least once.

GetIt it = GetIt.instance;

Future<void> registerServices() async{

  final apiClient = ApiClient(basePath: "http://51.77.137.143:8080");
  final Object cacheClient;

  if(kIsWeb){
    cacheClient = await SharedPreferences.getInstance();
  }else{
    cacheClient = const FlutterSecureStorage(
      aOptions: AndroidOptions(resetOnError: true)
    );
  }

  it.registerLazySingleton(() => ApiService(client: apiClient));
  it.registerLazySingleton(() => CacheService(client: cacheClient));
}