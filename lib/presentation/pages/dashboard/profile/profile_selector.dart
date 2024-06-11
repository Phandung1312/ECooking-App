import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_state.dart';


class ProfileStatusSelector
    extends BlocSelector<ProfileBloc, ProfileState, ProfileStatus> {
  ProfileStatusSelector({
    required Widget Function(ProfileStatus data) builder,
  }) : super(
          selector: (state) => state.status,
          builder: (_, status) => builder(status),
        );
}
class ProfileSelector<T> extends BlocSelector<ProfileBloc, ProfileState, T>{
  ProfileSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
    builder: (_, data) => builder(data),
  );
}
class ProfileStatusListener extends BlocListener<ProfileBloc, ProfileState> {
  ProfileStatusListener({
    required Iterable<ProfileStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
