import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uq_system_app/core/exceptions/exception.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/domain/entities/recipe.dart';

part 'home_state.freezed.dart';

enum HomeStatus {
  initial,
  loading,
  loadingPopularRecipes,
  loadedPopularRecipes,
  loadingNewestRecipes,
  loadingMore,
  loadedNewestRecipes,
  loadingTopMembers,
  loadedTopMembers,
  success,
  failure,
}

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
     @Default(<Recipe>[]) List<Recipe> popularRecipes,
     @Default(<Recipe>[]) List<Recipe> newestRecipes,
    @Default(<Member>[]) List<Member> topMembers,
    @Default(1) int newestRecipesPage,
    @Default(HomeStatus.initial) HomeStatus status,
    BaseException? error,
  }) = _HomeState;
}
