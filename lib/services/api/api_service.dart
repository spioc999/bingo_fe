import 'dart:convert';

import 'package:bingo_fe/services/api/api_client.dart';
import 'package:bingo_fe/services/models/assign_cards_request.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';
import 'package:bingo_fe/services/models/create_room_response.dart';
import 'package:bingo_fe/services/models/joined_room_response.dart';
import 'package:bingo_fe/services/models/next_bingo_paper_request.dart';
import 'package:bingo_fe/services/models/online_players_response.dart';
import 'package:bingo_fe/services/models/user_cards.dart';
import 'package:bingo_fe/services/models/winners_response.dart';
import 'package:bingo_fe/services/service_response.dart';
import 'package:dio/dio.dart';


/// [ApiService] is the class containing all the methods to invoke the BE endpoints.
/// Each method returns a [ServiceResponse] object, with result if all went correctly.
/// Otherwise in the response object, a [ServiceError] object is created and added to response.
///
/// In this way, the notifier that wants to retrieve information, has a unified interface
/// for all the data to verify if error occurred or not.

class ApiService{
  final ApiClient client;

  ApiService({required this.client});

  /// ROOM
  Future<ServiceResponse<CreateRoomResponse>> createNewRoom(String roomName, String nickname, {CancelToken? cancelToken}) async {
    ServiceResponse<CreateRoomResponse> response = ServiceResponse();

    try{
      response.result = await client.makePost<CreateRoomResponse>("/room/create/$roomName/$nickname",
          cancelToken: cancelToken,
          converter: (data) => CreateRoomResponse.fromJson(jsonDecode(data)));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
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
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  Future<ServiceResponse<String>> extractNumber(String roomCode, String hostUniqueCode, {CancelToken? cancelToken}) async {
    ServiceResponse<String> response = ServiceResponse();

    try{
      response.result = await client.makePost<String>("/room/extract/$roomCode/$hostUniqueCode",
          cancelToken: cancelToken,
          converter: (data) => data);

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  Future<ServiceResponse<int>> getLastExtractedNumber(String roomCode, {CancelToken? cancelToken}) async {
    ServiceResponse<int> response = ServiceResponse();

    try{
      response.result = await client.makeGet<int>("/room/last_extracted_number/$roomCode",
          cancelToken: cancelToken,
          converter: (data) => int.tryParse(data) ?? 0);

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  Future<ServiceResponse<OnlinePlayersResponse>> getOnlinePlayersRoom(String roomCode, {CancelToken? cancelToken}) async {
    ServiceResponse<OnlinePlayersResponse> response = ServiceResponse();

    try{
      response.result = await client.makeGet<OnlinePlayersResponse>("/room/online_players/$roomCode",
          cancelToken: cancelToken,
          converter: (data) => OnlinePlayersResponse.fromJson(data));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  Future<ServiceResponse<WinnersResponse>> getWinnersOfRoom(String roomCode, {CancelToken? cancelToken}) async {
    ServiceResponse<WinnersResponse> response = ServiceResponse();

    try{
      response.result = await client.makeGet<WinnersResponse>("/room/winners/$roomCode",
          cancelToken: cancelToken,
          converter: (data) => WinnersResponse.fromJson(data));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  /// PAPER
  Future<ServiceResponse<BingoPaper>> getNextBingoPaperOfRoom(String roomCode, List<int> exclude, {CancelToken? cancelToken}) async {
    ServiceResponse<BingoPaper> response = ServiceResponse();

    NextBingoPaperRequest body = NextBingoPaperRequest(exclude: exclude);

    try{
      response.result = await client.makePost<BingoPaper>("/paper/next/$roomCode",
          body: body.toJson(), cancelToken: cancelToken,
          converter: (data) => BingoPaper.fromJson(jsonDecode(data)));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }


  /// USER
  Future<ServiceResponse<UserCards>> getUserCards(String roomCode, String nickname, {CancelToken? cancelToken}) async {
    ServiceResponse<UserCards> response = ServiceResponse();

    try{
      response.result = await client.makeGet<UserCards>("/user/$roomCode/$nickname/cards",
          cancelToken: cancelToken,
          converter: (data) => UserCards.fromJson(jsonDecode(data)));

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  Future<ServiceResponse<String>> assignCardsToUser(String roomCode, String nickname, List<int> cards, {CancelToken? cancelToken}) async {
    ServiceResponse<String> response = ServiceResponse();

    AssignCardsRequest body = AssignCardsRequest(cards: cards);

    try{
      response.result = await client.makePost<String>("/user/card/assign/$roomCode/$nickname",
          body: body.toJson(), cancelToken: cancelToken,
          converter: (data) => data);

    } on DioError catch (e) {
      response.error = ServiceError(e.response?.statusCode ?? _genericError.errorCode, e.response?.data ?? e.response?.statusMessage ?? _genericError.errorMessage);
    }catch(e) {
      response.error = _genericError;
    }

    return response;
  }

  ServiceError get _genericError => ServiceError(0, "Generic Error");
}