import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/domain/entities/image.dart';
part 'image.response.freezed.dart';
part 'image.response.g.dart';
@freezed
class ImageResponse with _$ImageResponse {
  const ImageResponse._();
  const factory ImageResponse({
    required int id,
    required String url,
  }) = _ImageResponse;

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);

  Image mapToEntity() {
    return Image(
      id: id,
      url: url,
    );
  }
}
