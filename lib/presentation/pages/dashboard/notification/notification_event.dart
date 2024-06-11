import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'notification_event.freezed.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.errorOccurred([BaseException? error]) = NotificationErrorOccurred;
  const factory NotificationEvent.load({required bool isLoadMore}) = NotificationLoad;
  const factory NotificationEvent.getNew({required int id}) = NotificationGetNew;
  const factory NotificationEvent.countUnread() = NotificationCountUnread;
  const factory NotificationEvent.markAsRead({required int id}) = NotificationMarkAsRead;
}
