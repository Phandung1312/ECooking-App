


import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/sources/socket/socket_constant.dart';
import 'package:uq_system_app/env.dart';
import 'package:uq_system_app/presentation/blocs/socket/socket.state.dart';

import '../../../core/bases/responses/base_response.dart';
import '../../../data/services/auth/auth.services.dart';

@lazySingleton
class SocketCubit extends Cubit<SocketState> {
  late IO.Socket socket;
  final AuthServices _authServices;
  SocketCubit(this._authServices) : super(const SocketState(status: SocketStatus.initial));



  void connect() async {
    final token = await _authServices.getAccessToken();
    socket = IO.io(
      AppEnv.baseSocketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({
        'Authorization': 'Bearer $token'
      }).disableAutoConnect().build());
    if(!socket.connected){
      socket.connect();
      socket.onConnect((_) {
        print('Socket connected');
      });
      _listenCountUnread();
      _listenNewNotification();
      socket.onDisconnect((_) {
        print('Socket disconnected');
      });
    }
  }
  void _listenCountUnread() {
    socket.on(SocketConstant.countUnread, (data) {
      final count = BaseResponse<int>.fromJson(data, (json) => json as int).data;
      print('count: $count');
      emit(state.copyWith(status: SocketStatus.notificationChanged, countUnreadNotification: count));
    });
  }

  void _listenNewNotification() {
    socket.on(SocketConstant.newNotification, (data) {
      final id = BaseResponse<int>.fromJson(data, (json) => json as int).data;
      print('new notification: $id');
      emit(state.copyWith(status: SocketStatus.receivedNewNotification, newNotificationId: id));
    });
  }
  void disconnect() {

  }

  void sendMessage(String message) {

  }
}