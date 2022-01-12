import 'dart:convert';

import 'package:bingo_fe/models/room_info.dart';
import 'package:bingo_fe/services/service_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [CacheService] is the class containing all the methods retrieve data from local storage.
/// Each method returns a [ServiceResponse] object, with result if all went correctly.
/// Otherwise in the response object, a [ServiceError] object is created and added to response.
///
/// As web application runs within not secured web server, it was needed to use different package
/// for cache. For Android and iOS, [FlutterSecureStorage] is used and for WEB [SharedPreferences].
///
/// All writing, reading and deleting actions passed throw the custom implementation methods
/// [_read], [_write] and [_delete] which verify the type of [client] object and invoke the
/// right API.

class CacheService{
  static const int cacheNotFoundCode = 404;
  static const String cacheNotFoundMessage = "Not found";
  static const int cacheErrorCode = 500;
  static const String cacheErrorMessage = "Cache error";

  final Object client;

  CacheService({required this.client});

  Future<ServiceResponse> saveIsHost(bool? isHost) async {
    ServiceResponse response = ServiceResponse();
    try{
      await _write(
          key: StorageKeys.isHost,
          value: (isHost ?? false).toString());
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<bool>> isHost() async {
    ServiceResponse<bool> response = ServiceResponse();
    String? data = await _read(key: StorageKeys.isHost);
    response.result = data == 'true' ? true : false;
    return response;
  }

  Future<ServiceResponse> saveNickname(String? nickname) async {
    ServiceResponse response = ServiceResponse();
    try{
      await _write(
          key: StorageKeys.nickname,
          value: nickname);
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<String>> getNickname() async {
    ServiceResponse<String> response = ServiceResponse();
    String? data = await _read(key: StorageKeys.nickname);
    if(data == null){
      response.error = _notFoundError;
      return response;
    }
    response.result = data;
    return response;
  }

  Future<ServiceResponse> saveRoomInfo(RoomInfo? roomInfo) async {
    ServiceResponse response = ServiceResponse();
    try{
      await _write(
          key: StorageKeys.roomInfo,
          value: roomInfo == null ? null : jsonEncode(roomInfo.toJson()));
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<ServiceResponse<RoomInfo>> getRoomInfo() async {
    ServiceResponse<RoomInfo> response = ServiceResponse();
    String? data = await _read(key: StorageKeys.roomInfo);
    if(data == null){
      response.error = _notFoundError;
      return response;
    }
    try{
      response.result = RoomInfo.fromJson(jsonDecode(data));
    } catch (_) {
      response.error = _genericError;
    }
    return response;
  }

  Future<void> _write({required String key, required String? value}) async{
    if(client is FlutterSecureStorage){
      await (client as FlutterSecureStorage).write(key: key, value: value);
    }else if(client is SharedPreferences){
      await (client as SharedPreferences).setString(key, value ?? '');
    }
  }

  Future<String?> _read({required String key}) async{
    if(client is FlutterSecureStorage){
      return await (client as FlutterSecureStorage).read(key: key);
    }else if(client is SharedPreferences){
      return await Future.value((client as SharedPreferences).getString(key));
    }
    return Future.value(null);
  }

  Future<void> _delete({required String key}) async{
    if(client is FlutterSecureStorage){
      await (client as FlutterSecureStorage).delete(key: key);
    }else if(client is SharedPreferences){
      await (client as SharedPreferences).remove(key);
    }
  }

  ServiceError get _notFoundError =>
      ServiceError(cacheNotFoundCode, cacheNotFoundMessage);

  ServiceError get _genericError =>
      ServiceError(cacheErrorCode, cacheErrorMessage);
}

class StorageKeys{
  static const isHost = 'IS_HOST';
  static const nickname = 'NICKNAME';
  static const roomInfo = 'ROOM_INFO';
}