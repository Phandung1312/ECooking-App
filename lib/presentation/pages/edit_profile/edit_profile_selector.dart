import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_bloc.dart';
import 'package:uq_system_app/presentation/pages/edit_profile/edit_profile_state.dart';

class EditProfileSelector<T>
    extends BlocSelector<EditProfileBloc, EditProfileState, T> {
  EditProfileSelector({
    required Widget Function(T data) builder,
    required super.selector
  }) : super(
          builder: (_, data) => builder(data),
        );
}
class EditProfileBuilder<T>
extends BlocBuilder<EditProfileBloc, EditProfileState> {
EditProfileBuilder({
required Iterable<EditProfileStatus> statuses,
super.key,
required super.builder
}) : super(
buildWhen: (previousState, currentState) =>
previousState.status != currentState.status && statuses.contains(currentState.status),
);
}
class EditProfileStatusListener extends BlocListener<EditProfileBloc, EditProfileState> {
  EditProfileStatusListener({
    required Iterable<EditProfileStatus> statuses,
    super.key,
    required super.listener,
  }) : super(
          listenWhen: (previousState, currentState) =>
              previousState.status != currentState.status && statuses.contains(currentState.status),
        );
}
