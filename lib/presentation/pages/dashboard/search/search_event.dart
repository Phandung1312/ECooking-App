import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/params/search.params.dart';

part 'search_event.freezed.dart';

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.errorOccurred([BaseException? error]) =
      SearchErrorOccurred;

  const factory SearchEvent.getSuggestions(String keyword) =
      SearchGetSuggestions;

  const factory SearchEvent.getResult(
      {required SearchParams params,required bool isRefresh}) = SearchGetResult;
}
