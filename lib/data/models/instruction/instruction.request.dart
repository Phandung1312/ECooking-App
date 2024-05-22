

import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'instruction.request.freezed.dart';

@freezed
class InstructionRequest with _$InstructionRequest{
  const factory InstructionRequest({
    @Default(0) int id,
    int? order,
    String? title,
    String? content,
    int? startAt,
    int? endAt,
    List<File>? images,
  }) = _InstructionRequest;
}