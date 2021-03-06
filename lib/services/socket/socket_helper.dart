import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

/// [SocketHelper] is the helper class that provides functionalities to [createSocket],
/// [joinRoomSocket] by emitting a [SocketEventTypeEnum.joinRoom] event, [leaveRoomSocket] by
/// emitting a [SocketEventTypeEnum.leaveRoom] event and [addListenersOnSocket] for all the
/// [SocketEventTypeEnum] type of events.
///
/// [createSocket] creates a [IO.io] socket object and specifies the protocol
/// based on platform: ANDROID/iOS => "websocket" | WEB => "polling" (default)

class SocketHelper {

  static Socket createSocket(String url){
    final Map<String, dynamic> opts;
    if(kIsWeb){
      opts = <String, dynamic> {
        'autoConnect' : false
      };
    }else{
      opts = <String, dynamic> {
        'transports' : ['websocket'],
        'autoConnect' : false
      };
    }
    final socket = IO.io(url, opts);
    return socket;
  }

  static void joinRoomSocket(Socket? socket, String? roomCode, String? nickname){
    socket?.emit(SocketEventTypeEnum.joinRoom.name, {
      "room_code" : roomCode,
      "user_nickname" : nickname
    });
  }

  static void leaveRoomSocket(Socket? socket){
    socket?.emit(SocketEventTypeEnum.leaveRoom.name);
  }

  static void addListenersOnSocket(Socket? socket,
      { Function(dynamic)? onErrorMessage,
        Function(dynamic)? onRoomServiceMessages,
        Function(dynamic)? onExtractedNumber,
        Function(dynamic)? onWinnerEvent,
        Function(dynamic)? onUpdatedCard,
      }) {

    if(onErrorMessage != null){
      socket?.on(SocketEventTypeEnum.errorMessage.name, onErrorMessage);
    }

    if(onRoomServiceMessages != null){
      socket?.on(SocketEventTypeEnum.roomServiceMessages.name, onRoomServiceMessages);
    }

    if(onExtractedNumber != null){
      socket?.on(SocketEventTypeEnum.extractedNumber.name, onExtractedNumber);
    }

    if(onWinnerEvent != null){
      socket?.on(SocketEventTypeEnum.winnerEvent.name, onWinnerEvent);
    }

    if(onUpdatedCard != null){
      socket?.on(SocketEventTypeEnum.updatedCard.name, onUpdatedCard);
    }

  }
}

enum SocketEventTypeEnum {
  joinRoom,
  leaveRoom,
  errorMessage,
  roomServiceMessages,
  extractedNumber,
  winnerEvent,
  updatedCard
}

extension SocketEventTypeEnumExtension on SocketEventTypeEnum{
  String get name {
    switch(this){
      case SocketEventTypeEnum.joinRoom:
        return 'join_room';
      case SocketEventTypeEnum.leaveRoom:
        return 'leave_room';
      case SocketEventTypeEnum.errorMessage:
        return 'ErrorMessage';
      case SocketEventTypeEnum.roomServiceMessages:
        return 'RoomServiceMessages';
      case SocketEventTypeEnum.extractedNumber:
        return 'ExtractedNumber';
      case SocketEventTypeEnum.winnerEvent:
        return 'WinnerEvent';
      case SocketEventTypeEnum.updatedCard:
        return 'UpdatedCard';
    }
  }
}