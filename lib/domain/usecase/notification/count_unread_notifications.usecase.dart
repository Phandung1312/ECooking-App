

import 'package:injectable/injectable.dart';

import '../../../core/bases/usecases/base_use_case.dart';
import '../../repositories/notification.repository.dart';

@injectable
class CountUnreadNotificationsUseCase extends UseCase<int, NoParams?> {
  final NotificationRepository repository;

  CountUnreadNotificationsUseCase({required this.repository});

  @override
  Future<int> call([NoParams? params]) async {
    return await repository.countUnreadNotifications();
  }
}