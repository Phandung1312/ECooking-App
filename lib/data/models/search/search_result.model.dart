
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/data/models/instruction/instruction.response.dart';
import 'package:uq_system_app/domain/entities/search_result.dart';

import '../recipe/recipe.model.dart';
part 'search_result.model.freezed.dart';
part 'search_result.model.g.dart';
@freezed
class SearchResultModel with _$SearchResultModel{
  const SearchResultModel._();
  const factory SearchResultModel({
    required List<RecipeModel> recipes,
    required List<AccountResponse> accounts,
    required List<InstructionResponse> instructions,
  }) = _SearchResultModel;
  factory SearchResultModel.fromJson(Map<String, dynamic> json) => _$SearchResultModelFromJson(json);
  SearchResult mapToEntity(){
    return SearchResult(
      recipes: recipes.map((e) => e.mapToEntity()).toList(),
      accounts: accounts.map((e) => e.mapToEntity()).toList(),
      instructions: instructions.map((e) => e.mapToEntity()).toList(),
    );
  }
}