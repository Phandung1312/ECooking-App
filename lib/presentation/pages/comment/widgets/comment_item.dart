import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/string.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/comment.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;

  const CommentItem({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(comment.author.avatarUrl),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.author.displayName,
                  style: context.typographies.bodyBold,
                ),
                Text(
                  comment.createdAt.formatTimeWithDate(),
                  style: context.typographies.caption1
                      .withColor(context.colors.text.withOpacity(0.5)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(comment.content, style: context.typographies.body,),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Phản hồi",
                  style: context.typographies.caption2Bold
                      .withColor(context.colors.text.withOpacity(0.8)),
                ),
                if (comment.subComments.isNotEmpty) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: comment.subComments.length,
                    itemBuilder: (context, index) =>
                        CommentItem(comment: comment.subComments[index]),
                  )
                ]
              ],
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.more_vert),
          //   color: context.colors.secondary,
          //   onPressed: () {},
          // )
        ],
      ),
    );
  }
}
