
import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/instruction/instruction.request.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';

import '../../../domain/entities/enum/enum_mapper.dart';
part 'recipe_details.request.freezed.dart';
part 'recipe_details.request.g.dart';
@freezed
class RecipeDetailsRequest with _$RecipeDetailsRequest{
  const factory RecipeDetailsRequest({
    int? id,
    String? title,
    String? content,
    String? image,
    String? video,
    String? cookTime,
    String? servers,
    @Default(<String>[]) List<String> ingredients,
    @Default(<InstructionRequest>[]) List<InstructionRequest> instructions,
    @RecipeStatusConverter() @Default(RecipeStatus.draft) RecipeStatus status,
  }) = _RecipeDetailsRequest;
  factory RecipeDetailsRequest.fromJson(Map<String, dynamic> json) => _$RecipeDetailsRequestFromJson(json);
}