import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

import '../../../../domain/entities/member.dart';

class MemberItem extends StatelessWidget {
  final Member member;
  final void Function() onFollow;

  const MemberItem({Key? key, required this.member, required this.onFollow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(UserProfileRoute(userId: member.id));
      },
      child: Container(
        decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: context.colors.hint.withOpacity(0.5), width: 1)),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(member.avatarUrl),
              backgroundColor: context.colors.hint,
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              member.displayName,
              style: context.typographies.body.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              member.username,
              style: context.typographies.body.copyWith(
                fontSize: 14,
                color: context.colors.hint,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${member.recipeCount.formatNumber()} công thức',
              style: context.typographies.body.copyWith(
                fontSize: 14,
                color: context.colors.primary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${member.followingCount.formatNumber()} follower',
              style: context.typographies.body.copyWith(
                fontSize: 14,
                color: context.colors.primary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: (){
                onFollow();
              },
              child: !member.isFollowing
                  ? Container(
                      decoration: BoxDecoration(
                        color: context.colors.secondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text("Theo dõi",
                          style: context.typographies.body
                              .copyWith(color: Colors.white)),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: context.colors.hint.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text("Đang theo dõi",
                          style: context.typographies.bodyBold),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
