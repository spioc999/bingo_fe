import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/services/api/api_service.dart';
import 'package:bingo_fe/services/cache/cache_service.dart';
import 'package:bingo_fe/services/models/create_room_response.dart';
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