
import 'package:uq_system_app/domain/entities/notification.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';

abstract class NotificationRepository{
  Future<List<Notification>> getNotifications(CommonPaginateParams params);
  Future<Notification> getNewNotification(int id);
  Future<int> countUnreadNotifications();
  Future<void> markAsRead(int id);
}