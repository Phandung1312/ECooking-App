

import 'package:uq_system_app/domain/entities/enum/enum.dart';

class Utils {
  static String notificationTypeToString(NotificationType type){
    switch(type){
      case NotificationType.follow:
        return "đã bắt đầu follow bạn";
      case NotificationType.like:
        return "đã thích công thức của bạn";
      case NotificationType.commentRecipe:
        return "đã bình luận về công thức của bạn";
      case NotificationType.responseComment:
        return "đã phản hồi bình luận của bạn";
      case NotificationType.recipe:
        return "đã đăng tải công thức mới";
      case NotificationType.save:
        return "đã lưu công thức của bạn";
      default:
        return "";
    }
  }
}
