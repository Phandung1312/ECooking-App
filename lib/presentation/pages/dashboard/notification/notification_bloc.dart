import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/usecase/notification/count_unread_notifications.usecase.dart';
import 'package:uq_system_app/domain/usecase/notification/get_notification.usecase.dart';
import 'package:uq_system_app/domain/usecase/notification/read_notification.usecase.dart';

import '../../../../domain/usecase/notification/get_notifications.usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

@injectable
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final CountUnreadNotificationsUseCase _countUnreadNotificationsUseCase;
  final ReadNotificationUseCase _readNotificationUseCase;
  final GetNotificationUseCase _getNotificationUseCase;
  RefreshController refreshController = RefreshController(initialRefresh: true);

  NotificationBloc(
      this._getNotificationsUseCase, this._countUnreadNotificationsUseCase, this._readNotificationUseCase, this._getNotificationUseCase)
      : super(const NotificationState()) {
    on<NotificationErrorOccurred>(_onErrorOccurred);
    on<NotificationLoad>(_onLoad);
    on<NotificationCountUnread>(_onCountUnread);
    on<NotificationMarkAsRead>(_onMarkAsRead);
    on<NotificationGetNew>(_onGetNew);
  }
  FutureOr<void> _onMarkAsRead(NotificationMarkAsRead event, Emitter<NotificationState> emit) async {
    await _readNotificationUseCase(event.id);
    final notifications = state.notifications.map((e) {
      if (e.id == event.id) {
        return e.copyWith(isRead: true);
      }
      return e;
    }).toList();
    emit(state.copyWith(notifications: notifications));
  }
  FutureOr<void> _onGetNew(NotificationGetNew event, Emitter<NotificationState> emit) async {
    final notification = await _getNotificationUseCase(event.id);
    emit(state.copyWith(notifications: [notification, ...state.notifications], status: NotificationStatus.success));
  }
  FutureOr<void> _onLoad(NotificationLoad event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(
      status: NotificationStatus.loading,
      page : event.isLoadMore ? state.page  : 1,
    ));
    final notifications = await _getNotificationsUseCase(CommonPaginateParams(
      page: state.page,
      perPage: 20,
    ));
    if(event.isLoadMore ) {
      refreshController.loadComplete();
    } else {
      refreshController.refreshCompleted();
    }
    emit(state.copyWith(
      notifications: event.isLoadMore
          ? [...state.notifications, ...notifications]
          : notifications,
      status: NotificationStatus.success,
      page: state.page + 1,
    ));
  }
  FutureOr<void> _onCountUnread(
    NotificationCountUnread event,
    Emitter<NotificationState> emit,
  ) async {
    final totalUnread = await _countUnreadNotificationsUseCase();
    emit(state.copyWith(
      totalUnread: totalUnread,
    ));
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    add(NotificationErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    NotificationErrorOccurred event,
    Emitter<NotificationState> emit,
  ) {
    emit(state.copyWith(
      status: NotificationStatus.failure,
    ));
  }
}
