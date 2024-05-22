
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/image.dart';

import 'account.dart';
part 'instruction.freezed.dart';
@freezed
class Instruction with _$Instruction {
  const factory Instruction({
    @Default(0) int id,
    @Default(0) int recipeId,
    @Default('') String content,
    @Default('') String title,
    @Default(0) int startAt,
    @Default(0) int endAt,
    @Default(0) int order,
    @Default(<Image>[]) List<Image> images,
    @Default(Account()) Account author,
  }) = _Instruction;
}