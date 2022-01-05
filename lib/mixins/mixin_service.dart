import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/services/api/api_service.dart';
import 'package:bingo_fe/services/cache/cache_service.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';
import 'package:bingo_fe/services/models/create_room_response.dart';
import 'package:bingo_fe/services/models/joined_room_response.dart';
import 'package:bingo_fe/services/service_response.dart';
import 'package:get_it/get_it.dart';

mixin ServiceMixin on BaseNotifier {

  final ApiService apiService = GetIt.instance<ApiService>();
  final CacheService cacheService = GetIt.instance<CacheService>();

  ///API
  Future<ServiceResponse<CreateRoomResponse>> createNewRoom(String roomName, String nickname, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<CreateRoomResponse> response = await apiService.createNewRoom(roomName, nickname, cancelToken: cancelToken);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<JoinedRoomResponse>> joinRoom(String roomCode, String nickname, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<JoinedRoomResponse> response = await apiService.joinRoom(roomCode, nickname, cancelToken: cancelToken);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<BingoPaper>> getNextBingoPaperOfRoom(String roomCode, List<int> exclude, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<BingoPaper> response = await apiService.getNextBingoPaperOfRoom(roomCode, exclude, cancelToken: cancelToken);
    if(!isSilent) hideLoading();
    return response;
  }

  ///CACHE

  Future<ServiceResponse> saveIsHost(bool? isHost, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveIsHost(isHost);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<bool>> isHostUser({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<bool> response = await cacheService.isHost();
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse> saveRoomCreatedAndPaper(CreateRoomResponse? roomCreatedAndPaper, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveRoomCreatedAndPaper(roomCreatedAndPaper);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<CreateRoomResponse>> getRoomCreatedAndPaper({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<CreateRoomResponse> response = await cacheService.getRoomCreatedAndPaper();
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse> saveBingoPaper(BingoPaper? bingoPaper, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveBingoPaper(bingoPaper);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<BingoPaper>> getBingoPaper({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<BingoPaper> response = await cacheService.getBingoPaper();
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse> saveNickname(String? nickname, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveNickname(nickname);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<String>> getNickname({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<String> response = await cacheService.getNickname();
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse> saveRoomCode(String? roomCode, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveRoomCode(roomCode);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<String>> getRoomCode({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<String> response = await cacheService.getRoomCode();
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse> saveRoomName(String? roomName, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveRoomName(roomName);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<String>> getRoomName({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<String> response = await cacheService.getRoomName();
    if(!isSilent) hideLoading();
    return response;
  }

  ///---------------------------------------------------------------------
  ///ERROR AND SUCCESS HELPER
  String getErrorTextByServiceError(ServiceError error){
    switch(error.errorCode){
      case 404:
        return 'Error 404: NOT FOUND!';
      default:
        return 'Ops! Something went wrong!';
    }
  }

}