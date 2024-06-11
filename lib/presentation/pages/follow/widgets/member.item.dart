import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

class MemberItem extends StatelessWidget {
  const MemberItem({
    Key? key,
    required this.member,
    required this.onFollow,  this.isMe = false,
  }) : super(key: key);

  final Member member;
  final bool isMe;
  final void Function(bool isFollow) onFollow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(isMe) {
          context.router.push(ProfileRoute(isFromDashboard: false));
        }
        else{
          context.router.push(UserProfileRoute(userId: member.id));
        }
      } ,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(member.avatarUrl),
              backgroundColor: context.colors.hint,
              radius: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.displayName, style: context.typographies.bodyBold),
                  Text("@${member.username}",
                      style: context.typographies.body
                          .withColor(context.colors.text.withOpacity(0.5))),
                  Row(
                    children: [
                      Text("${member.followingCount.formatNumber()} follower",
                          style: context.typographies.body
                              .withColor(context.colors.text.withOpacity(0.5))),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${member.recipeCount.formatNumber()} công thức",
                          style: context.typographies.body
                              .withColor(context.colors.text.withOpacity(0.5))),
                    ],
                  )
                ],
              ),
            ),
            if(isMe)  Icon(Icons.arrow_forward_ios_rounded, color: context.colors.primary,)
            else if (member.isFollowing)
              InkWell(
                onTap: () {
                  onFollow(false);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.colors.hint.withOpacity(0.5)),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text("Đang theo dõi",
                      style: context.typographies.caption1Bold
                          .withColor(context.colors.primary)),
                ),
              )
            else
              InkWell(
                onTap: () {
                  onFollow(true);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colors.secondary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text("Theo dõi",
                      style: context.typographies.caption1Bold
                          .copyWith(color: Colors.white)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
