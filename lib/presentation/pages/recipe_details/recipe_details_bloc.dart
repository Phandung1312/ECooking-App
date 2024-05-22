import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair/pair.dart';
import 'package:uq_system_app/domain/entities/params/paginate_comment_params.dart';
import 'package:uq_system_app/domain/usecase/recipe/get_suggest_recipes.usecase.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_event.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_state.dart';

import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/entities/recipe_details.dart';
import '../../../domain/usecase/comment/get_comments.usecase.dart';
import '../../../domain/usecase/recipe/get_recipe_details.usecase.dart';
@injectable
class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  final GetRecipeDetailsDetailsUseCase getRecipeDetailsDetailsUseCase;
  final GetSuggestRecipesUseCase getSuggestRecipesUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  RecipeDetailsBloc(this.getRecipeDetailsDetailsUseCase, this.getSuggestRecipesUseCase,this.getCommentsUseCase) : super(const RecipeDetailsState()) {
    on<RecipeDetailsErrorOccurred>(_onErrorOccurred);
    on<RecipeDetailsLoad>(_onLoad);
    on<RecipeDetailsLoadComments>(_onLoadComments);
    on<RecipeDetailsLoadSuggests>(_onLoadSuggests);
  }
  FutureOr<void> _onLoad(RecipeDetailsLoad event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.loading,
    ));
    await Future.wait([
      getRecipeDetailsDetailsUseCase(event.recipeId),
      getCommentsUseCase(PaginateCommentParams(recipeId: event.recipeId, page: 1, perPage: 3)),
    ]).then((value)  {
      final recipeDetails = value[0] as RecipeDetails;
      final pair = value[1] as Pair<int, List<Comment>>;
      emit(state.copyWith(
        recipeDetails: recipeDetails,
        comments: pair.value,
        totalComments: pair.key,
        status: RecipeDetailsStatus.success,
      ));
      add(RecipeDetailsLoadSuggests(recipeDetails.title));
    });
  }
  FutureOr<void> _onLoadSuggests(RecipeDetailsLoadSuggests event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.loadingSuggests,
    ));
    final suggests = await getSuggestRecipesUseCase(event.title);
    emit(state.copyWith(
      suggests: suggests,
      status: RecipeDetailsStatus.loadedSuggests,
    ));
  }
  FutureOr<void> _onLoadComments(RecipeDetailsLoadComments event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.loadingComments,
    ));
    final comments = await getCommentsUseCase(PaginateCommentParams(recipeId: event.recipeId, page: 1, perPage: 3));
    emit(state.copyWith(
      comments: comments.value,
      totalComments: comments.key,
      status: RecipeDetailsStatus.loadedComments,
    ));
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    add(RecipeDetailsErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    RecipeDetailsErrorOccurred event,
    Emitter<RecipeDetailsState> emit,
  ) {
    emit(state.copyWith(
      status: RecipeDetailsStatus.failure,
    ));
  }
}
