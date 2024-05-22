



import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';

import '../../../../../domain/entities/account.dart';

class AccountItem extends StatelessWidget {
  const AccountItem({
    Key? key,
    required this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.background,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(account.avatarUrl),
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
                Text(account.displayName,
                    style: context.typographies.bodyBold),
                Text("@${account.username}",
                    style: context.typographies.body
                        .withColor(context.colors.text.withOpacity(0.5))),
              ],
            ),
          ),
          // if (userAccount?.id != recipe.author.id)
            Container(
              decoration: BoxDecoration(
                color: context.colors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text("Theo dõi",
                  style: context.typographies.body
                      .copyWith(color: Colors.white)),
            ),
        ],
      ),
    );
  }
}