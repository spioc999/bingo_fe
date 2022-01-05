import 'dart:convert';

import 'package:bingo_fe/services/api/api_client.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';
import 'package:bingo_fe/services/models/create_room_response.dart';
import 'package:bingo_fe/services/models/joined_room_response.dart';
import 'package:bingo_fe/services/service_response.dart';
import 'package:dio/dio.dart';

class ApiService{
  final ApiClient client;

  ApiService({required this.client});


  Future<ServiceResponse<CreateRoomResponse>> createNewRoom(String roomName, String nickname, {CancelToken? cancelToken}) async {
    ServiceResponse<CreateRoomResponse> response = ServiceResponse();

    try{
      response.result = await client.makePost<CreateRoomResponse>("/room/create/$roomName/$nickname",
          cancelToken: cancelToken,
          converter: (data) => CreateRoomResponse.fromJson(jsonDecode(data)));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  Future<ServiceResponse<JoinedRoomResponse>> joinRoom(String roomCode, String nickname, {CancelToken? cancelToken}) async {
    ServiceResponse<JoinedRoomResponse> response = ServiceResponse();

    try{
      response.result = await client.makePost<JoinedRoomResponse>("/room/join/$roomCode/$nickname",
          cancelToken: cancelToken,
          converter: (data) => JoinedRoomResponse.fromJson(jsonDecode(data)));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  ServiceError get _genericError => ServiceError(0, "Generic Error");
}