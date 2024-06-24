import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'saved_recipes_event.freezed.dart';

@freezed
class SavedRecipesEvent with _$SavedRecipesEvent {
  const factory SavedRecipesEvent.errorOccurred([BaseException? error]) = SavedRecipesErrorOccurred;
  const factory SavedRecipesEvent.loadDraftRecipes() = SavedRecipesLoadDraftRecipes;
}
