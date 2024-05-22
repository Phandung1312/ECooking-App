
import 'package:freezed_annotation/freezed_annotation.dart';
part 'image.freezed.dart';
@freezed
class Image with _$Image{
  const factory Image({
    @Default(0) int id,
    @Default('') String url,
  }) = _Image;
}