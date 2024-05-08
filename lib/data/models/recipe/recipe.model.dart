import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
part 'recipe.model.freezed.dart';
part 'recipe.model.g.dart';
@freezed
class RecipeModel with _$RecipeModel {
const RecipeModel._();
  const factory RecipeModel({
     required int id,
    required String title,
    String? content,
    required int views,
    required int likeCount,
    String? cookTime,
    String? servers,
    required int status,
    required AccountResponse account,
    String? imageUrl,
    required bool isVideo,
    required String createdAt,
  }) = _RecipeModel;
  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
  Recipe mapToEntity(){
    return Recipe(
      id: id,
      title:  title,
      content: content ?? "",
      views: views,
      likeCount: likeCount,
      cookTime: cookTime ?? "",
      servers: servers ?? "",
      status: status,
      account: account.mapToEntity(),
      imageUrl: imageUrl ?? "",
      isVideo: isVideo,
      createdAt: createdAt,
    );
  }
}