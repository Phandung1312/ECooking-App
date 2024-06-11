import 'package:freezed_annotation/freezed_annotation.dart';
part 'socket.state.freezed.dart';
enum SocketStatus { initial, notificationChanged, receivedNewNotification }

@freezed
class SocketState with _$SocketState {
  const factory SocketState({
    @Default(0) int countUnreadNotification,
    @Default(0) int newNotificationId,
    @Default(SocketStatus.initial) SocketStatus status,
  }) = _SocketState;
}
