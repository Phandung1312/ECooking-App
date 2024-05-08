
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/account.dart';

part 'account.response.freezed.dart';
part 'account.response.g.dart';
@freezed
class AccountResponse with _$AccountResponse{
  const AccountResponse._();
    const factory AccountResponse({
      required int id,
      String? username,
      String? displayName,
      String? avatarUrl,
}) = _AccountReponse;
    factory AccountResponse.fromJson(Map<String, dynamic> json) =>
        _$AccountResponseFromJson(json);
    Account mapToEntity(){
      return Account(
        id: id,
        username: username ?? "",
        displayName: displayName ?? "",
        avatarUrl: avatarUrl ?? "",
      );
    }
}