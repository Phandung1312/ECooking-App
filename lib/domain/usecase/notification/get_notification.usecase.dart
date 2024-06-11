

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/domain/entities/notification.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/notification.repository.dart';

@injectable
class GetNotificationUseCase extends UseCase<Notification, int> {
  final NotificationRepository _notificationRepository;

  GetNotificationUseCase(this._notificationRepository);


  @override
  Future<Notification> call(int params) {
   return _notificationRepository.getNewNotification(params);
  }
}