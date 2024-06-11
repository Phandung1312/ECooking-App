
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/enum/enum_mapper.dart';
part 'recipe_feature.request.freezed.dart';
part 'recipe_feature.request.g.dart';
@freezed
class RecipeFeatureRequest with _$RecipeFeatureRequest {
  const factory RecipeFeatureRequest({
    required int recipeId,
    @FeatureStatusConverter() required FeatureStatus status,
  }) = _RecipeFeatureRequest;

  factory RecipeFeatureRequest.fromJson(Map<String, dynamic> json) => _$RecipeFeatureRequestFromJson(json);
}