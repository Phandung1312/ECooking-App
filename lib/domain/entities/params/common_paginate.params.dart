

import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_paginate.params.freezed.dart';
part 'common_paginate.params.g.dart';
@freezed
class CommonPaginateParams with _$CommonPaginateParams{
  const factory CommonPaginateParams({
    @Default(0) int id,
    @Default(0) int page,
    @Default(10) int perPage,
  }) = _CommonPaginateParams;
  factory CommonPaginateParams.fromJson(Map<String, dynamic> json) =>
      _$CommonPaginateParamsFromJson(json);
}