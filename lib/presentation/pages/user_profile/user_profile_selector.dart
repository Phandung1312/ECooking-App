import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/user_profile/user_profile_state.dart';

class UserProfileSelector<T>
    extends BlocSelector<UserProfileBloc, UserProfileState, T> {
  UserProfileSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class UserProfileBuilder<T>
extends BlocBuilder<UserProfileBloc, UserProfileState> {
UserProfileBuilder({
required Iterable<UserProfileStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class UserProfileStatusListener extends BlocListener<UserProfileBloc, UserProfileState> {
  UserProfileStatusListener({
    required Iterable<UserProfileStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
