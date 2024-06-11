import 'package:freezed_annotation/freezed_annotation.dart';

part 'instruction.request.freezed.dart';

part 'instruction.request.g.dart';

@freezed
class InstructionRequest with _$InstructionRequest {
  const factory InstructionRequest({
    @JsonKey(includeToJson: false) @Default(0) int id,
    int? order,
    String? title,
    String? content,
    int? startAt,
    int? endAt,
    List<String>? images,
  }) = _InstructionRequest;

  factory InstructionRequest.fromJson(Map<String, dynamic> json) =>
      _$InstructionRequestFromJson(json);
}
