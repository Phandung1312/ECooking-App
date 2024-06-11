import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/string.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/notification.dart'
    as notification_entity;
import 'package:uq_system_app/utils/utils.dart';

class NotificationItem extends StatelessWidget {
  final notification_entity.Notification notification;
  final void Function(int id)? onAvatarTap;
  final void Function(int recipeId)? onContentTap;

  const NotificationItem({Key? key, required this.notification, this.onAvatarTap, this.onContentTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(notification.type != NotificationType.follow){
          onContentTap?.call(notification.recipe.id);
        }
        else{
          onAvatarTap?.call(notification.sender.id);
        }
      },
      child: Container(
        color: notification.isRead
            ? Colors.white
            : context.colors.hint.withOpacity(0.2),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            InkWell(
              onTap: (){
                onAvatarTap?.call(notification.sender.id);
              },
              child: CircleAvatar(
                backgroundImage: notification.sender.avatarUrl.isNotEmpty
                    ? NetworkImage(notification.sender.avatarUrl)
                    : null,
                backgroundColor: context.colors.hint,
                radius: 30,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: notification.sender.displayName,
                        style: context.typographies.bodyBold,
                      ),
                      TextSpan(
                        text: ' ${Utils.notificationTypeToString(notification.type)}.',
                        style: context.typographies.body,
                      ),
                      TextSpan(
                        text: ' ${notification.createdAt.formatTimeAgo()}',
                        style: context.typographies.body.withColor(context.colors.primary.withOpacity(0.5)),
                      )
                    ],
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            if (notification.recipe.imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: notification.recipe.imageUrl,
                fit: BoxFit.cover,
                height: 80,
                width: 80,
                errorWidget: (context, url, error) => Container(
                  height: 80,
                  color: context.colors.hint,
                ),
                placeholder: (context, url) => Container(
                  height: 80,
                  color: context.colors.hint,
                ),
              )
          ],
        ),
      ),
    );
  }
}
