import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/data/models/account/account.response.dart';
import 'package:uq_system_app/domain/entities/instruction.dart';

import '../../../domain/entities/account.dart';
import '../image/image.response.dart';
part 'instruction.response.freezed.dart';
part 'instruction.response.g.dart' ;
@freezed
class InstructionResponse with _$InstructionResponse {
  const InstructionResponse._();
  const factory InstructionResponse({
    required int id,
    required String content,
    int? recipeId,
     String? title,
     int? startAt,
    int? endAt ,
    required int order,
    required List<ImageResponse> images,
    AccountResponse? author,
  }) = _InstructionResponse;

  factory InstructionResponse.fromJson(Map<String, dynamic> json) =>
      _$InstructionResponseFromJson(json);
  Instruction mapToEntity(){
    return Instruction(
      id: id,
      recipeId: recipeId ?? 0,
      content: content,
      order: order,
      title: title ?? '',
      startAt: startAt ?? 0,
      endAt: endAt ?? 0,
      images: images.map((e) => e.mapToEntity()).toList(),
      author: author?.mapToEntity() ?? const Account(),
    );
  }
}
