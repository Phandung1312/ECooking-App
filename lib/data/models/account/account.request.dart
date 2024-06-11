

import 'package:freezed_annotation/freezed_annotation.dart';
part 'account.request.freezed.dart';
part 'account.request.g.dart';
@freezed
class AccountRequest with _$AccountRequest {
  const factory AccountRequest({
    int? id,
    String? avatarUrl,
    String? displayName,
    String? story,
    String? address,
  }) = _AccountRequest;

  factory AccountRequest.fromJson(Map<String, dynamic> json) => _$AccountRequestFromJson(json);
}