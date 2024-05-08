import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

class RecipeSkeleton extends StatelessWidget {
  final RecipeSearchType type;
  const RecipeSkeleton({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    if(type == RecipeSearchType.POPULAR){
      return _buildPopularRecipe(context);
    }
    else{
      return _buildNewestRecipe(context);
    }
  }

  Widget _buildPopularRecipe(BuildContext context){
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border:
        Border.all(color: context.colors.hint.withOpacity(0.2), width: 1),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SkeletonItem(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(10),
                  height: 200,
                  width: 320,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                      borderRadius: BorderRadius.circular(10),
                      height: 20,
                      minLength: 100,
                      maxLength: 200
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 48, height: 48, shape: BoxShape.circle)),
                    const SizedBox(
                      width: 5,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          borderRadius: BorderRadius.circular(10),
                          height: 20,
                          width: 200
                      ),
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }
  Widget _buildNewestRecipe(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border:
        Border.all(color: context.colors.hint.withOpacity(0.2), width: 1),
      ),

      child: SkeletonItem(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  borderRadius: BorderRadius.circular(10),
                  height: 135,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                      borderRadius: BorderRadius.circular(10),
                      height: 15,
                      minLength: 100,
                      maxLength: 150
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    const SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 48, height: 48, shape: BoxShape.circle)),
                    const SizedBox(
                      width: 5,
                    ),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                          borderRadius: BorderRadius.circular(10),
                          height: 13,
                          width: 50
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SkeletonLine(
                  style: SkeletonLineStyle(
                      borderRadius: BorderRadius.circular(10),
                      height: 10,
                      width: 100
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
