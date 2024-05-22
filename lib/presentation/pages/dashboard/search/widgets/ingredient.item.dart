import 'package:flutter/material.dart';
import 'package:uq_system_app/assets.gen.dart';
import 'package:uq_system_app/core/extensions/text_style.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/domain/entities/template/ingredient.template.dart';

class IngredientItem extends StatelessWidget {
  final IngredientTemplate ingredientTemplate;
  final void Function(String value)? onTap;

  const IngredientItem({Key? key, required this.ingredientTemplate, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap?.call(ingredientTemplate.name);
      },
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
            child: AssetGenImage(ingredientTemplate.imagePath).image(
              width: 200,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 10,
              bottom: 10,
              child: Text(
            ingredientTemplate.name,
            style: context.typographies.title3.withColor(Colors.white),
          ))
        ],
      ),
    );
  }
}
