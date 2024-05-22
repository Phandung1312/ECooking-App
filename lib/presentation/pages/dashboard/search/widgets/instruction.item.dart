

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/instruction.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

import '../../../../../assets.gen.dart';

class InstructionItem extends StatelessWidget{
  final Instruction instruction;
  const InstructionItem({
    Key? key,
    required this.instruction,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        context.router.push(RecipeDetailsRoute(id: instruction.recipeId, instructionOrder: instruction.order));
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    instruction.title,
                    style: context.typographies.title3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    instruction.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: context.typographies.body.copyWith(
                      color: context.colors.hint,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        NetworkImage(instruction.author.avatarUrl),
                        backgroundColor: context.colors.hint,
                        radius: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          instruction.author.displayName,
                          overflow: TextOverflow.ellipsis,
                          style: context.typographies.caption2,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children : [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: CachedNetworkImage(
                      //TODO : Handle when images is empty
                      imageUrl: instruction.images.isNotEmpty ?  instruction.images[0].url : "",
                      fit: BoxFit.cover,
                      height: 100,
                      width: 100,
                      errorWidget: (context, url, error) => Container(
                        height: 100,
                        width: 100,
                        color: context.colors.hint,
                      ),
                      placeholder: (context, url) => Container(
                        height: 100,
                        width: 100,
                        color: context.colors.hint,
                      ),
                    ),
                  ),
                ),
                AssetGenImage(Assets.icons.png.icVideo.path)
                    .image(width: 32, height: 32, fit: BoxFit.cover),
              ]
            )
          ],
        ),
      ),
    );
  }

}