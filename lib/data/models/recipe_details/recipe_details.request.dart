
import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/instruction/instruction.request.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
part 'recipe_details.request.freezed.dart';
@freezed
class RecipeDetailsRequest with _$RecipeDetailsRequest{
  const factory RecipeDetailsRequest({
    String? title,
    String? content,
    File? image,
    File? video,
    String? cookTime,
    String? servers,
    @Default(<String>[]) List<String> ingredients,
    @Default(<InstructionRequest>[]) List<InstructionRequest> instructions,
    @Default(RecipeStatus.draft) RecipeStatus status,
  }) = _RecipeDetailsRequest;

}