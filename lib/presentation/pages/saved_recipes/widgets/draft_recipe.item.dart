

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';

import '../../../navigation/navigation.dart';

class DraftRecipeItem extends StatelessWidget {
  final Recipe recipe;
  final void Function(bool isUpdated) onTap;
  const DraftRecipeItem({Key? key, required this.recipe, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        var result = await context.router.push(CreateRecipeRoute(recipeId: recipe.id));
        if(result != null) {
          onTap(true);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: BorderRadius.circular(10),
        ),
        width: 150,
        height: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: recipe.imageUrl,
              width: 150,
              height: 110,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 150,
                color: context.colors.hint,
              ),
              placeholder: (context, url) => Container(
                height: 150,
                color: context.colors.hint.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                recipe.title,
                style: context.typographies.bodyBold,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

}