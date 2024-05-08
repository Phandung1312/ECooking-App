import 'package:freezed_annotation/freezed_annotation.dart';
part 'google_login_params.freezed.dart';
part 'google_login_params.g.dart';
@freezed
class GoogleLoginParams with _$GoogleLoginParams {
  const factory GoogleLoginParams({
    @JsonKey(name: 'id_token') required String idToken
  }) = _GoogleLoginParams;
  factory GoogleLoginParams.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginParamsFromJson(json);
}