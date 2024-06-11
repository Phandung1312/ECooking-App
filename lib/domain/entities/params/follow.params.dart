

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/enum/enum_mapper.dart';

part 'follow.params.freezed.dart';
part 'follow.params.g.dart';
@freezed
class FollowParams with _$FollowParams {
  const factory FollowParams({
    required int followedId,
    @FeatureStatusConverter() required FeatureStatus status,
  }) = _FollowParams;
  factory FollowParams.fromJson(Map<String, dynamic> json) => _$FollowParamsFromJson(json);
}