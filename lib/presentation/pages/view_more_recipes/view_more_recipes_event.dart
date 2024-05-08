import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'view_more_recipes_event.freezed.dart';

@freezed
class ViewMoreRecipesEvent with _$ViewMoreRecipesEvent {
  const factory ViewMoreRecipesEvent.errorOccurred([BaseException? error]) = ViewMoreRecipesErrorOccurred;
  const factory ViewMoreRecipesEvent.load({required bool isLoadMore}) = ViewMoreRecipesLoad;
}
