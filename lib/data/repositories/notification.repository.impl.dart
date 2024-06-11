

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/data/sources/network/network.dart';
import 'package:uq_system_app/domain/entities/notification.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';

import '../../domain/repositories/notification.repository.dart';

@LazySingleton(as: NotificationRepository)
class NotificationRepositoryImpl extends NotificationRepository {
  final NetworkDataSource networkDataSource;

  NotificationRepositoryImpl({required this.networkDataSource});

  @override
  Future<int> countUnreadNotifications() async{
    var result = await networkDataSource.countUnreadNotification();
    return result.data;
  }

  @override
  Future<List<Notification>> getNotifications(CommonPaginateParams params) async{
    var result = await networkDataSource.getNotifications(params.page, params.perPage);
    return result.data.map((e) => e.mapToEntity()).toList();
  }

  @override
  Future<void> markAsRead(int id) async{
    await networkDataSource.markAsRead(id);
  }

  @override
  Future<Notification> getNewNotification(int id) async{
    var result = await networkDataSource.getNotification(id);
    return result.data.mapToEntity();
  }

}