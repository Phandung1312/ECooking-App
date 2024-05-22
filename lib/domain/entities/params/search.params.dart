
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
part 'search.params.freezed.dart';
@freezed
class SearchParams with _$SearchParams {
  const factory SearchParams({
    @Default('') String title,
    @Default(1) int page,
    @Default(20) int perPage,
    @Default(SearchType.all) SearchType type,
  }) = _SearchParams;
}