

import 'package:freezed_annotation/freezed_annotation.dart';
part 'ingredient.freezed.dart';
@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    @Default(0) int id,
    @Default("") String content,
  }) = _Ingredient;
}