


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/number.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/instruction.dart';

class InstructionItem extends StatelessWidget {
  final Instruction instruction;
  final void Function(int startAt) onTitleTap;

  const InstructionItem({
    Key? key,
    required this.instruction,
    required this.onTitleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xF6FCD5D1),
              radius: 15,
              child: Text(
                instruction.order.toString(),
                style: context.typographies.caption1.withColor(context.colors.secondary),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(instruction.title.isNotEmpty)
                    Text(
                      instruction.title,
                      style: context.typographies.title3Bold,
                    ),
                  const SizedBox(height: 5),
                  Text(
                    instruction.content,
                    style: context.typographies.body,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        if(instruction.images.isNotEmpty)
          Container(
            padding: const EdgeInsets.only(left: 40),
            height: 100,
            child: ListView.separated(
              shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: instruction.images.length,
                itemBuilder: (context, index) {
              final image = instruction.images[index];
              return CachedNetworkImage(
                imageUrl : image.url,
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>   Container(
                  height: 50,
                  color: context.colors.hint,
                ),
                placeholder: (context, url) =>  Container(
                  height: 50,
                  color: context.colors.hint,
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  width: 10,
                );
            }, ),
          ),
        if(instruction.title.isNotEmpty)...[
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(width: 40),
              InkWell(
                onTap: (){
                  onTitleTap(instruction.startAt);
                },
                child: Text(
                  "${instruction.startAt.formatTime()} - ${instruction.endAt.formatTime()}",
                  style: context.typographies.bodyBold.copyWith(
                    color: context.colors.information,
                  ),
                ),
              ),
            ],
          ),
        ]
      ],
    );
  }
}