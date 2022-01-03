import 'package:bingo_fe/services/service_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService{
  static const int cacheNotFoundCode = 404;
  static const String cacheNotFoundMessage = "Not found";
  static const int cacheErrorCode = 500;
  static const String cacheErrorMessage = "Cache error";

  final FlutterSecureStorage client;

  CacheService({required this.client});

  Future<ServiceResponse> saveLastRoomName(String? roomName) async {
    ServiceResponse response = ServiceResponse();
    try{
      await client.write(
          key: StorageKeys.lastRoomName,
          value: roomName);
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<String>> getLastRoomName() async {
    ServiceResponse<String> response = ServiceResponse();
    String? data = await client.read(key: StorageKeys.lastRoomName);
    if(data == null){
      response.error = _notFoundError;
      return response;
    }
    response.result = data;
    return response;
  }

  Future<ServiceResponse> saveLastRoomWebSocket(String? webSocket) async {
    ServiceResponse response = ServiceResponse();
    try{
      await client.write(
          key: StorageKeys.lastRoomWebSocket,
          value: webSocket);
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<String>> getLastRoomWebSocket() async {
    ServiceResponse<String> response = ServiceResponse();
    String? data = await client.read(key: StorageKeys.lastRoomWebSocket);
    if(data == null){
      response.error = _notFoundError;
      return response;
    }
    response.result = data;
    return response;
  }

  ServiceError get _notFoundError =>
      ServiceError(cacheNotFoundCode, cacheNotFoundMessage);

  ServiceError get _genericError =>
      ServiceError(cacheErrorCode, cacheErrorMessage);
}

class StorageKeys{
  static const lastRoomName = 'LAST_ROOM_NAME';
  static const lastRoomWebSocket = 'LAST_ROOM_WEB_SOCKET';
}