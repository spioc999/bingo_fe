import 'dart:convert';

import 'package:bingo_fe/services/models/create_room_response.dart';
import 'package:bingo_fe/services/service_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheService{
  static const int cacheNotFoundCode = 404;
  static const String cacheNotFoundMessage = "Not found";
  static const int cacheErrorCode = 500;
  static const String cacheErrorMessage = "Cache error";

  final FlutterSecureStorage client;

  CacheService({required this.client});

  Future<ServiceResponse> saveIsHost(bool? isHost) async {
    ServiceResponse response = ServiceResponse();
    try{
      await client.write(
          key: StorageKeys.isHost,
          value: (isHost ?? false).toString());
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<bool>> isHost() async {
    ServiceResponse<bool> response = ServiceResponse();
    String? data = await client.read(key: StorageKeys.isHost);
    response.result = data == 'true' ? true : false;
    return response;
  }

  Future<ServiceResponse> saveRoomCreatedAndPaper(CreateRoomResponse? roomCreatedAndPaper) async {
    ServiceResponse response = ServiceResponse();
    try{
      await client.write(
          key: StorageKeys.roomCreatedAndPaper,
          value: roomCreatedAndPaper == null ? null : jsonEncode(roomCreatedAndPaper.toJson()));
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<CreateRoomResponse>> getRoomCreatedAndPaper() async {
    ServiceResponse<CreateRoomResponse> response = ServiceResponse();
    String? data = await client.read(key: StorageKeys.roomCreatedAndPaper);
    if(data == null){
      response.error = _notFoundError;
      return response;
    }
    try{
      response.result = CreateRoomResponse.fromJson(jsonDecode(data));
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse> saveNickname(String? nickname) async {
    ServiceResponse response = ServiceResponse();
    try{
      await client.write(
          key: StorageKeys.nickname,
          value: nickname);
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<String>> getNickname() async {
    ServiceResponse<String> response = ServiceResponse();
    String? data = await client.read(key: StorageKeys.nickname);
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
  static const isHost = 'IS_HOST';
  static const roomCreatedAndPaper = 'ROOM_CREATED_AND_PAPER';
  static const nickname = 'NICKNAME';
}