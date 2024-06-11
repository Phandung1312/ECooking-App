



import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/notification.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../entities/params/common_paginate.params.dart';
import '../../repositories/notification.repository.dart';

@injectable
class GetNotificationsUseCase extends UseCase< List<Notification>, CommonPaginateParams> {
  final NotificationRepository _notificationRepository;

  GetNotificationsUseCase(this._notificationRepository);

  @override
  Future<List<Notification>> call(CommonPaginateParams params) {
    return _notificationRepository.getNotifications(params);
  }


}