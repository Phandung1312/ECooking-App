import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pair/pair.dart';
import 'package:uq_system_app/data/models/recipe_feature/recipe_feature.request.dart';
import 'package:uq_system_app/domain/entities/enum/enum.dart';
import 'package:uq_system_app/domain/entities/params/paginate_comment_params.dart';
import 'package:uq_system_app/domain/entities/params/suggest_recipe.params.dart';
import 'package:uq_system_app/domain/usecase/recipe/get_suggest_recipes.usecase.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_event.dart';
import 'package:uq_system_app/presentation/pages/recipe_details/recipe_details_state.dart';

import '../../../core/exceptions/exception.dart';
import '../../../data/models/report/report.request.dart';
import '../../../domain/entities/comment.dart';
import '../../../domain/entities/recipe_details.dart';
import '../../../domain/usecase/comment/get_comments.usecase.dart';
import '../../../domain/usecase/recipe/change_recipe_favorite.usecase.dart';
import '../../../domain/usecase/recipe/change_saved_recipe.usecase.dart';
import '../../../domain/usecase/recipe/delete_recipe.usecase.dart';
import '../../../domain/usecase/recipe/get_recipe_details.usecase.dart';
import '../../../domain/usecase/report/report.usecase.dart';
import '../../../domain/usecase/user/update_follow.usecase.dart';

@injectable
class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  final GetRecipeDetailsDetailsUseCase getRecipeDetailsDetailsUseCase;
  final GetSuggestRecipesUseCase getSuggestRecipesUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final ChangeRecipeFavorite _changeRecipeFavorite;
  final ChangeSavedRecipeUseCase _changeSavedRecipeUseCase;
  final UpdateFollowUseCase _updateFollowUseCase;
  final DeleteRecipeUseCase _deleteRecipeUseCase;
  final CreateReportUseCase _createReportUseCase;


  RecipeDetailsBloc(
      this.getRecipeDetailsDetailsUseCase,
      this.getSuggestRecipesUseCase,
      this.getCommentsUseCase,
      this._changeRecipeFavorite,
      this._changeSavedRecipeUseCase, this._updateFollowUseCase, this._deleteRecipeUseCase, this._createReportUseCase)
      : super(const RecipeDetailsState()) {
    on<RecipeDetailsErrorOccurred>(_onErrorOccurred);
    on<RecipeDetailsLoad>(_onLoad);
    on<RecipeDetailsLoadComments>(_onLoadComments);
    on<RecipeDetailsLoadSuggests>(_onLoadSuggests);
    on<RecipeDetailsChangeSaved>(_onChangeSavedRecipe);
    on<RecipeDetailsChangeFavorite>(_onChangeFavorite);
    on<RecipeDetailsChangeFollow>(_onChangeFollow);
    on<RecipeDetailsDelete>(_onDelete);
    on<RecipeDetailsReport>(_onReport);
  }
  FutureOr<void> _onReport(RecipeDetailsReport event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.reporting,
    ));
    await _createReportUseCase(ReportRequest(
      content: event.content,
      recipeId: state.recipeDetails.id,
    ));
    emit(state.copyWith(
      status: RecipeDetailsStatus.reported,
    ));
  }
  FutureOr<void> _onChangeFollow(
    RecipeDetailsChangeFollow event,
    Emitter<RecipeDetailsState> emit,
  ) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.updating,
    ));
    await _updateFollowUseCase(event.params);
    emit(state.copyWith(
      recipeDetails: state.recipeDetails.copyWith(
        author: state.recipeDetails.author.copyWith(
          isFollowing: !state.recipeDetails.author.isFollowing,
        ),
      ),
      status: RecipeDetailsStatus.updated,
    ));
  }
  Future<void> _onDelete(RecipeDetailsDelete event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.deleting,
    ));
    await _deleteRecipeUseCase(state.recipeDetails.id);
    emit(state.copyWith(
      status: RecipeDetailsStatus.deleted,
    ));
  }
  FutureOr<void> _onLoad(
      RecipeDetailsLoad event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.loading,
    ));
    await Future.wait([
      getRecipeDetailsDetailsUseCase(event.recipeId),
      getCommentsUseCase(
          PaginateCommentParams(recipeId: event.recipeId, page: 1, perPage: 3)),
    ]).then((value) {
      final recipeDetails = value[0] as RecipeDetails;
      final pair = value[1] as Pair<int, List<Comment>>;
      emit(state.copyWith(
        recipeDetails: recipeDetails,
        comments: pair.value,
        totalComments: pair.key,
        status: RecipeDetailsStatus.success,
      ));
      add(RecipeDetailsLoadSuggests(SuggestRecipeParams(id: recipeDetails.id, title: recipeDetails.title)));
    });
  }
  FutureOr<void> _onChangeFavorite(
    RecipeDetailsChangeFavorite event,
    Emitter<RecipeDetailsState> emit,
  ) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.updating,
    ));
    await _changeRecipeFavorite(RecipeFeatureRequest(
        recipeId: state.recipeDetails.id,
        status: !state.recipeDetails.isFavorite
            ? FeatureStatus.enable
            : FeatureStatus.disable));
    emit(state.copyWith(
      recipeDetails: state.recipeDetails.copyWith(
        isFavorite: !state.recipeDetails.isFavorite,
        likeCount: state.recipeDetails.likeCount +
            (state.recipeDetails.isFavorite ? -1 : 1),
      ),
      status: RecipeDetailsStatus.updated,
    ));
  }
  FutureOr<void> _onChangeSavedRecipe(
    RecipeDetailsChangeSaved event,
    Emitter<RecipeDetailsState> emit,
  ) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.updating,
    ));
    await _changeSavedRecipeUseCase(RecipeFeatureRequest(
        recipeId: state.recipeDetails.id,
        status: !state.recipeDetails.isSaved
            ? FeatureStatus.enable
            : FeatureStatus.disable));
    emit(state.copyWith(
      recipeDetails:
          state.recipeDetails.copyWith(isSaved: !state.recipeDetails.isSaved),
      status: RecipeDetailsStatus.success,
    ));
  }

  FutureOr<void> _onLoadSuggests(
      RecipeDetailsLoadSuggests event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.loadingSuggests,
    ));
    final suggests = await getSuggestRecipesUseCase(event.params);
    emit(state.copyWith(
      suggests: suggests,
      status: RecipeDetailsStatus.loadedSuggests,
    ));
  }

  FutureOr<void> _onLoadComments(
      RecipeDetailsLoadComments event, Emitter<RecipeDetailsState> emit) async {
    emit(state.copyWith(
      status: RecipeDetailsStatus.loadingComments,
    ));
    final comments = await getCommentsUseCase(
        PaginateCommentParams(recipeId: event.recipeId, page: 1, perPage: 3));
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
