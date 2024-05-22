
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/account.dart';
import 'package:uq_system_app/domain/entities/instruction.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';
part 'search_result.freezed.dart';
@freezed
class SearchResult with _$SearchResult {
  const factory SearchResult({
   @Default(<Recipe>[]) List<Recipe> recipes,
   @Default(<Account>[]) List<Account> accounts,
   @Default(<Instruction>[]) List<Instruction> instructions,
  }) = _SearchResult;

}