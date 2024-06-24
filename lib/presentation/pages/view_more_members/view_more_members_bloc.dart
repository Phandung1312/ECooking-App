import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/domain/entities/params/common_paginate.params.dart';
import 'package:uq_system_app/domain/usecase/user/get_topmembers.usecase.dart';
import 'package:uq_system_app/domain/usecase/user/update_follow.usecase.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_event.dart';
import 'package:uq_system_app/presentation/pages/view_more_members/view_more_members_state.dart';
import '../../../core/exceptions/exception.dart';

@injectable
class ViewMoreMembersBloc
    extends Bloc<ViewMoreMembersEvent, ViewMoreMembersState> {
  final GetTopMembersUseCase _getMembersUseCase;
  final UpdateFollowUseCase _updateFollowUseCase;
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  ViewMoreMembersBloc(this._getMembersUseCase, this._updateFollowUseCase)
      : super(const ViewMoreMembersState()) {
    on<ViewMoreMembersErrorOccurred>(_onErrorOccurred);
    on<ViewMoreMembersLoad>(_onLoad);
    on<ViewMoreMembersChangeFollow>(_onChangeFollow);
  }

  FutureOr<void> _onLoad(
    ViewMoreMembersLoad event,
    Emitter<ViewMoreMembersState> emit,
  ) async {
    emit(state.copyWith(
      status: !event.isLoadMore
          ? ViewMoreMembersStatus.loading
          : ViewMoreMembersStatus.loadingMore,
      page: event.isLoadMore ? state.page : 1,
    ));
    final members = await _getMembersUseCase(CommonPaginateParams(
      page: state.page,
      perPage: 20,
    ));
    if (event.isLoadMore) {
      refreshController.loadComplete();
    } else {
      refreshController.refreshCompleted();
    }
    emit(state.copyWith(
      members: event.isLoadMore ? [...state.members, ...members] : members,
      page: members.isNotEmpty ? state.page + 1 : state.page,
      status: ViewMoreMembersStatus.success,
    ));
  }
  FutureOr<void> _onChangeFollow(
    ViewMoreMembersChangeFollow event,
    Emitter<ViewMoreMembersState> emit,
  ) async {
    emit(state.copyWith(
      status: ViewMoreMembersStatus.updating,
    ));
      await _updateFollowUseCase(event.followParams);
      final members = state.members.map((e) {
        if (e.id == event.followParams.followedId) {
          return e.copyWith(isFollowing: !e.isFollowing, followingCount: e.isFollowing ? e.followingCount - 1 : e.followingCount + 1);
        }
        return e;
      }).toList();
      emit(state.copyWith(members: members, status: ViewMoreMembersStatus.updated));

  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    if(refreshController.isLoading){
      refreshController.loadComplete();
    }
    if(refreshController.isRefresh){
      refreshController.refreshCompleted();
    }
    add(ViewMoreMembersErrorOccurred(BaseException.from(error)));
    super.onError(error, stackTrace);
  }

  FutureOr<void> _onErrorOccurred(
    ViewMoreMembersErrorOccurred event,
    Emitter<ViewMoreMembersState> emit,
  ) {

    emit(state.copyWith(
      status: ViewMoreMembersStatus.failure,
    ));
  }
}

