import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.errorOccurred([BaseException? error]) = HomeErrorOccurred;
  const factory HomeEvent.getTopMembers() = HomeGetTopMembers;
  const factory HomeEvent.getPopularRecipes() = HomeGetPopularRecipes;
  const factory HomeEvent.getNewestRecipes({required bool isLoadMore}) = HomeGetNewestRecipes;
}
