import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/data/models/ingredient/ingredient.response.dart';
import 'package:uq_system_app/data/models/instruction/instruction.response.dart';
import 'package:uq_system_app/data/models/member/member.model.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/enum/enum_mapper.dart';
import 'package:uq_system_app/domain/entities/recipe_details.dart';

part 'recipe_details.response.freezed.dart';

part 'recipe_details.response.g.dart';

@freezed
class RecipeDetailsResponse with _$RecipeDetailsResponse {
  const RecipeDetailsResponse._();

  const factory RecipeDetailsResponse({
    required int id,
    required String title,
    String? imageUrl,
    String? content,
    required int views,
    String? cookTime,
    String? servers,
    String? createdAt,
    required int likeCount,
    required MemberModel author,
    required List<IngredientResponse> ingredients,
    required List<InstructionResponse> instructions,
    String? videoUrl,
    @RecipeStatusConverter() required RecipeStatus status,
    bool? isLiked,
    bool? isSaved,
  }) = _RecipeDetailsResponse;

  factory RecipeDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsResponseFromJson(json);

  RecipeDetails mapToEntity() {
    return RecipeDetails(
        id: id,
        title: title,
        imageUrl: imageUrl ?? "",
        content: content ?? '',
        views: views,
        likeCount: likeCount,
        author: author.mapToEntity(),
        cookTime: cookTime ?? '',
        servers: servers ?? '',
        videoUrl: videoUrl ?? '',
        createdAt: createdAt ?? '',
        instructions: instructions.map((e) => e.mapToEntity()).toList(),
        ingredients: ingredients.map((e) => e.mapToEntity()).toList(),
        isFavorite: isLiked ?? false,
        isSaved: isSaved ?? false,
        status: status);
  }
}
