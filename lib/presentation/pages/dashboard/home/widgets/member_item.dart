import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/helpers/color.helper.dart';

import '../../../../navigation/navigation.dart';

class MemberItem extends StatelessWidget {
  final Member member;
  final int number;
  const MemberItem({Key? key, required this.member, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: InkWell(
        onTap: (){
           context.router.push(UserProfileRoute(userId: member.id));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(member.avatarUrl),
              backgroundColor: context.colors.hint,
              radius: 30,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.displayName,
                    style: context.typographies.bodyBold,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${member.recipeCount} công thức  |  ${member.followingCount} follower",
                      style: context.typographies.caption1.withColor(context.colors.hint.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: ColorHelper.getRankColor(number),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
               number.toString(),
                style: context.typographies.caption1Bold.withColor(Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
