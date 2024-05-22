
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account.freezed.dart';
part 'account.g.dart';
@freezed
class Account with _$Account{
  const factory Account({
    @Default(0) int id,
    @Default('') String username,
    @Default('') String displayName,
    @Default('') String email,
    @Default('') String avatarUrl,
  }) = _Account;
  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
}