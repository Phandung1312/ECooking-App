import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';

@freezed
class Account with _$Account {
  const factory Account({
    @JsonKey(name: 'user_id') required String id,
    @JsonKey(name: 'user_name') String? name,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'accessToken') required String? accessToken,
  }) = _Account;

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}
