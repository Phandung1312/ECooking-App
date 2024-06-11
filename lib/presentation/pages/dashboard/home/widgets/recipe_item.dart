import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uq_system_app/core/extensions/string.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
import 'package:uq_system_app/helpers/user_info.helper.dart';
import 'package:uq_system_app/presentation/navigation/navigation.dart';

import '../../../../../assets.gen.dart';

class RecipeItem extends StatefulWidget {
  final Recipe recipe;
  final RecipeSearchType type;
  final void Function(RecipeFeatureRequest request)? onSavedChange;
  const RecipeItem({super.key, required this.recipe, required this.type, this.onSavedChange});

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case RecipeSearchType.POPULAR:
        return _buildPopularRecipe();
      case RecipeSearchType.NEWEST:
        return _buildNewestRecipe();
      default:
        return _buildSearchRecipe();
    }
  }

  void _saveRecipe() async {
    var userInfoHelper = getIt.get<UserInfoHelper>();
    var isLogged = await userInfoHelper.isUserLogged();
    if (isLogged) {
      var request = RecipeFeatureRequest(
          recipeId: widget.recipe.id,
          status: widget.recipe.isSaved ? FeatureStatus.disable : FeatureStatus.enable);
      widget.onSavedChange?.call(request);
    } else {
      if (context.mounted) {
        var result = await context.router.push(const LoginRoute());
        if (result != null && result is bool && result) {}
      }
    }
  }

  Widget _buildPopularRecipe() {
    return InkWell(
      onTap: () {
        context.router.push(RecipeDetailsRoute(id: widget.recipe.id));
      },
      child: Container(
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: context.colors.hint.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.imageUrl,
                      width: 320,
                      height: 220,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        height: 220,
                        color: context.colors.hint,
                      ),
                      placeholder: (context, url) => Container(
                        height: 220,
                        color: context.colors.hint.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                if (widget.recipe.isVideo)
                  AssetGenImage(Assets.icons.png.icVideo.path)
                      .image(width: 48, height: 48, fit: BoxFit.cover),
                Positioned(
                    left: 10,
                    bottom: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AssetGenImage(Assets.icons.png.icView.path)
                            .image(width: 28, height: 28, fit: BoxFit.cover),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.recipe.views.toString(),
                          style: context.typographies.caption2.copyWith(
                              color: const Color(0xFFDEDEDE), fontSize: 20),
                        )
                      ],
                    )),
                Positioned(
                    right: 10,
                    top: 5,
                    child: InkWell(
                      onTap: _saveRecipe,
                      child: AssetGenImage(widget.recipe.isSaved
                          ? Assets.icons.png.icBookmarked.path
                          : Assets.icons.png.icBookmark.path)
                          .image(height: 32, color: widget.recipe.isSaved ? context.colors.secondary : const Color(0xFFDEDEDE)),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                widget.recipe.title,
                style: context.typographies.caption1Bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.recipe.account.avatarUrl),
                    backgroundColor: context.colors.hint,
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      widget.recipe.account.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: context.typographies.caption2,
                    ),
                  ),
                  AssetGenImage(widget.recipe.isLiked ? Assets.icons.png.icFavoriteFill.path :  Assets.icons.png.icFavorite.path).image(
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                      color: !widget.recipe.isLiked ? context.colors.text : null),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.recipe.likeCount.toString(),
                      style: context.typographies.caption2.withSize(14))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNewestRecipe() {
    return InkWell(
      onTap: () {
        context.router.push(RecipeDetailsRoute(id: widget.recipe.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: context.colors.hint.withOpacity(0.2), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.imageUrl,
                      height: 135,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        height: 135,
                        color: context.colors.hint,
                      ),
                      placeholder: (context, url) => Container(
                        height: 135,
                        color: context.colors.hint,
                      ),
                    ),
                  ),
                ),
                if (widget.recipe.isVideo)
                  AssetGenImage(Assets.icons.png.icVideo.path)
                      .image(width: 32, height: 32, fit: BoxFit.cover),
                Positioned(
                    left: 10,
                    bottom: 5,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AssetGenImage(Assets.icons.png.icView.path)
                            .image(width: 14, height: 14, fit: BoxFit.cover),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.recipe.views.toString(),
                          style: context.typographies.caption2.copyWith(
                              color: const Color(0xFFDEDEDE), fontSize: 10),
                        )
                      ],
                    )),
                Positioned(
                  right: 10,
                  top: 5,
                  child: InkWell(
                    onTap: _saveRecipe,
                    child: AssetGenImage(widget.recipe.isSaved
                        ? Assets.icons.png.icBookmarked.path
                        : Assets.icons.png.icBookmark.path)
                        .image(height: 24,color: widget.recipe.isSaved ? context.colors.secondary : const Color(0xFFDEDEDE)),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                widget.recipe.title,
                style: context.typographies.caption1Bold,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.recipe.account.avatarUrl),
                    backgroundColor: context.colors.hint,
                    radius: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      widget.recipe.account.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: context.typographies.caption2,
                    ),
                  ),
                  AssetGenImage(widget.recipe.isLiked ? Assets.icons.png.icFavoriteFill.path :  Assets.icons.png.icFavorite.path).image(
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                      color: !widget.recipe.isLiked ? context.colors.text : null),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(widget.recipe.likeCount.toString(),
                      style: context.typographies.caption2.withSize(14))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.recipe.createdAt.formatTimeAgo(),
                style: context.typographies.caption2
                    .withColor(context.colors.hint),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchRecipe() {
    return InkWell(
      onTap: () {
        context.router.push(RecipeDetailsRoute(id: widget.recipe.id));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: context.colors.hint.withOpacity(0.2), width: 1),
        ),
        height: 165,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      widget.recipe.title,
                      style: context.typographies.title3,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    const Expanded(child: SizedBox()),
                    if (widget.type == RecipeSearchType.SEARCH)
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.recipe.account.avatarUrl),
                            backgroundColor: context.colors.hint,
                            radius: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              widget.recipe.account.displayName,
                              overflow: TextOverflow.ellipsis,
                              style: context.typographies.caption2,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 10),
                    Text(
                      widget.recipe.createdAt.formatTimeAgo(),
                      style: context.typographies.caption2
                          .withColor(context.colors.hint),
                    ),
                    const SizedBox(height: 10),
                    Row(children: [
                      AssetGenImage(widget.recipe.isLiked ? Assets.icons.png.icFavoriteFill.path :  Assets.icons.png.icFavorite.path).image(
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                          color: !widget.recipe.isLiked ? context.colors.text : null),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.recipe.likeCount.toString(),
                          style: context.typographies.caption2.withSize(14)),
                      const SizedBox(
                        width: 20,
                      ),
                      AssetGenImage(Assets.icons.png.icView.path).image(
                          width: 18,
                          height: 18,
                          fit: BoxFit.cover,
                          color: context.colors.text),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(widget.recipe.views.toString(),
                          style: context.typographies.caption2)
                    ]),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4),
                      BlendMode.darken,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.recipe.imageUrl,
                      fit: BoxFit.cover,
                      height: 150,
                      width: 150,
                      errorWidget: (context, url, error) => Container(
                        height: 150,
                        color: context.colors.hint,
                      ),
                      placeholder: (context, url) => Container(
                        height: 150,
                        color: context.colors.hint,
                      ),
                    ),
                  ),
                ),
                if (widget.recipe.isVideo)
                  AssetGenImage(Assets.icons.png.icVideo.path)
                      .image(width: 32, height: 32, fit: BoxFit.cover),
               if(widget.type != RecipeSearchType.MY_RECIPE)
                 Positioned(
                   right: 5,
                   top: 5,
                   child: InkWell(
                     onTap: _saveRecipe,
                     child: AssetGenImage(widget.recipe.isSaved
                         ? Assets.icons.png.icBookmarked.path
                         : Assets.icons.png.icBookmark.path)
                         .image(height: 24, color: widget.recipe.isSaved ? context.colors.secondary : const Color(0xFFDEDEDE)),
                   ),
                 )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
