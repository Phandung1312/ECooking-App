
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/ingredient.dart';
part 'ingredient.response.freezed.dart';
part 'ingredient.response.g.dart';
@freezed
class IngredientResponse with _$IngredientResponse {
  const IngredientResponse._();
  const factory IngredientResponse({
     required int id,
    required String content,
  }) = _IngredientResponse;

  factory IngredientResponse.fromJson(Map<String, dynamic> json) =>
      _$IngredientResponseFromJson(json);
  Ingredient mapToEntity() {
    return Ingredient(
      id: id,
      content: content,
    );
  }
}