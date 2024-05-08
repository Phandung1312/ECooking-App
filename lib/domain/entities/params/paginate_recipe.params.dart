

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

part 'paginate_recipe.params.freezed.dart';
part 'paginate_recipe.params.g.dart';
@freezed
class PaginateRecipeParams with _$PaginateRecipeParams{
  const factory PaginateRecipeParams({
    @Default(0) int page,
    @Default(0) int perPage,
    @Default('') String recipeSearchType,
  }) = _PaginateRecipeParams;
  factory PaginateRecipeParams.fromJson(Map<String, dynamic> json) =>
      _$PaginateRecipeParamsFromJson(json);
}