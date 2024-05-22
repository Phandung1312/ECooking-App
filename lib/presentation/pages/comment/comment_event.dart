import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'comment_event.freezed.dart';

@freezed
class CommentEvent with _$CommentEvent {
  const factory CommentEvent.errorOccurred([BaseException? error]) = CommentErrorOccurred;
  const factory CommentEvent.load({required int recipeId, required bool isLoadMore}) = CommentLoad;
}
