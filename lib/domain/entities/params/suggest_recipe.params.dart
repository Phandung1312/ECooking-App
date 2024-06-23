

import 'package:freezed_annotation/freezed_annotation.dart';
part 'suggest_recipe.params.freezed.dart';
@freezed
class SuggestRecipeParams with _$SuggestRecipeParams {
  const factory SuggestRecipeParams({
    @Default(0) int id,
    @Default('') String title,
  }) = _SuggestRecipeParams;

}