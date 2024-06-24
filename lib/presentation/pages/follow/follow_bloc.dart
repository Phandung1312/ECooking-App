import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/domain/entities/member.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_event.dart';
import 'package:uq_system_app/presentation/pages/follow/follow_state.dart';
import '../../../core/exceptions/exception.dart';
import '../../../domain/entities/enum/enum.dart';
import '../../../domain/usecase/user/get_followers.usecase.dart';
import '../../../domain/usecase/user/get_followings.usecase.dart';
import '../../../domain/usecase/user/update_follow.usecase.dart';
@injectable
class FollowBloc extends Bloc<FollowEvent, FollowState> {
  late RefreshController followersController;
  late RefreshController followingsController;
  final GetFollowersUseCase _getFollowersUseCase;
  final GetFollowingsUseCase _getFollowingsUseCase;
  final UpdateFollowUseCase _updateFollowUseCase;
  FollowBloc(this._getFollowersUseCase, this._getFollowingsUseCase, this._updateFollowUseCase) : super(const FollowState()) {
    on<FollowErrorOccurred>(_onErrorOccurred);
    on<FollowLoadFollowers>(_onLoadFollowers);
    on<FollowLoadFollowings>(_onLoadFollowings);
    on<FollowUpdateUserId>(_onUpdateUserId);
    on<FollowUpdateFollow>(_onUpdateFollow);
  }
  _onUpdateUserId(FollowUpdateUserId event, Emitter<FollowState> emit) {
    emit(state.copyWith(
      userId: event.userId,
    ));
  }
  FutureOr<void> _onUpdateFollow(
    FollowUpdateFollow event,
    Emitter<FollowState> emit,
  ) async {
   await _updateFollowUseCase(event.params);
   if(event.type == FollowType.follower){
     var newFollowers = List<Member>.from(state.followers);
     var index = newFollowers.indexWhere((element) => element.id == event.params.followedId);
     if(index != -1){
       newFollowers[index] = newFollowers[index].copyWith(isFollowing: event.params.status == FeatureStatus.enable);
     }
     emit(state.copyWith(
       followers: newFollowers,
     ));
   }
   else{
      var newFollowings = List<Member>.from(state.followings);
      var index = newFollowings.indexWhere((element) => element.id == event.params.followedId);
      if(index != -1){
        newFollowings[index] = newFollowings[index].copyWith(isFollowing: event.params.status == FeatureStatus.enable);
      }
      emit(state.copyWith(
        followings: newFollowings,
      ));
   }
  }
  FutureOr<void> _onLoadFollowers(
    FollowLoadFollowers event,
    Emitter<FollowState> emit,
  ) async {
    emit(state.copyWith(
      status: FollowStatus.loading,
      currentFollowersPage: event.isLoadMore ? state.currentFollowersPage : 1,
    ));
    var result = await _getFollowersUseCase(CommonPaginateParams(
      id: state.userId,
      page: state.currentFollowersPage,
    ));
    if(event.isLoadMore){
      followersController.loadComplete();
    }
    else{
      followersController.refreshCompleted();
    }
    emit(state.copyWith(
      followers: event.isLoadMore ? [...state.followers, ...result] : result,
      status: FollowStatus.success,
      currentFollowersPage: result.isEmpty ? state.currentFollowersPage : state.currentFollowersPage + 1,
    ));
  }
  FutureOr<void> _onLoadFollowings(
    FollowLoadFollowings event,
    Emitter<FollowState> emit,
  ) async  {
    emit(state.copyWith(
      status: FollowStatus.loading,
      currentFollowingsPage: event.isLoadMore ? state.currentFollowingsPage : 1,
    ));
    var result = await _getFollowingsUseCase(CommonPaginateParams(
      id: state.userId,
      page: state.currentFollowingsPage,
    ));
    if(event.isLoadMore){
      followingsController.loadComplete();
    }
    else{
      followingsController.refreshCompleted();
    }
    emit(state.copyWith(
      followings: event.isLoadMore ? [...state.followings, ...result] : result,
      currentFollowingsPage: result.isEmpty ? state.currentFollowingsPage : state.currentFollowingsPage + 1,
      status: FollowStatus.success,
    ));
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    if(followingsController.isLoading){
      followingsController.loadComplete();
    }
    if(followersController.isLoading){
      followersController.loadComplete();
    }
    if(followersController.isRefresh){
      followersController.refreshCompleted();
    }
    if(followingsController.isRefresh){
      followingsController.refreshCompleted();
    }
    add(FollowErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    FollowErrorOccurred event,
    Emitter<FollowState> emit,
  ) {
    emit(state.copyWith(
      status: FollowStatus.failure,
    ));
  }
}
