import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';

import '../../../domain/entities/account.dart';
part 'recipe.model.freezed.dart';
part 'recipe.model.g.dart';
@freezed
class RecipeModel with _$RecipeModel {
const RecipeModel._();
  const factory RecipeModel({
     required int id,
    required String title,
    String? content,
    int? views,
    int? likeCount,
    String? cookTime,
    String? servers,
    int? status,
    AccountResponse? author,
    String? imageUrl,
    bool? isVideo,
    String? createdAt,
    bool? isLiked,
    bool? isSaved
  }) = _RecipeModel;
  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
  Recipe mapToEntity(){
    return Recipe(
      id: id,
      title:  title,
      content: content ?? "",
      views: views ?? 0,
      likeCount: likeCount ?? 0,
      cookTime: cookTime ?? "",
      servers: servers ?? "",
      status: status ?? 0,
      account: author?.mapToEntity() ?? const Account(),
      imageUrl: imageUrl ?? "",
      isVideo: isVideo ?? false,
      createdAt: createdAt ?? "",
      isLiked: isLiked ?? false,
      isSaved: isSaved ?? false
    );
  }
}