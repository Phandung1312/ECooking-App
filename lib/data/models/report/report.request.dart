
import 'package:freezed_annotation/freezed_annotation.dart';
part 'report.request.freezed.dart';
part 'report.request.g.dart';
@freezed
class ReportRequest with _$ReportRequest {
  const factory ReportRequest({
    required int recipeId,
    required String content,
  }) = _ReportRequest;
  factory ReportRequest.fromJson(Map<String, dynamic> json) => _$ReportRequestFromJson(json);
}