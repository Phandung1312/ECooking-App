

import 'package:injectable/injectable.dart';
import 'package:uq_system_app/core/bases/usecases/base_use_case.dart';

import '../../repositories/notification.repository.dart';

@injectable
class ReadNotificationUseCase extends UseCase<void, int>{
  final NotificationRepository _notificationRepository;
  const ReadNotificationUseCase(this._notificationRepository);
  @override
  Future<void> call(int params) {
    return _notificationRepository.markAsRead(params);
  }

}