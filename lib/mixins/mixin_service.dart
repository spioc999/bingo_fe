import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/services/api/api_service.dart';
import 'package:bingo_fe/services/cache/cache_service.dart';
import 'package:bingo_fe/services/service_response.dart';
import 'package:get_it/get_it.dart';

mixin ServiceMixin on BaseNotifier {

  final ApiService apiService = GetIt.instance<ApiService>();
  final CacheService cacheService = GetIt.instance<CacheService>();

  Future<ServiceResponse> saveLastRoomName(String? roomName, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveLastRoomName(roomName);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<String>> getLastRoomName({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<String> response = await cacheService.getLastRoomName();
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse> saveLastRoomWebSocket(String? webSocket, {bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse response = await cacheService.saveLastRoomWebSocket(webSocket);
    if(!isSilent) hideLoading();
    return response;
  }

  Future<ServiceResponse<String>> getLastRoomWebSocket({bool isSilent = false}) async {
    if(!isSilent) showLoading();
    ServiceResponse<String> response = await cacheService.getLastRoomWebSocket();
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