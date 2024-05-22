

import 'package:freezed_annotation/freezed_annotation.dart';
part 'ingredient.template.freezed.dart';
@freezed
class IngredientTemplate with _$IngredientTemplate {
  const factory IngredientTemplate({
    required String name,
    required String imagePath
  }) = _IngredientTemplate;


}