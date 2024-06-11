



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard.bloc.dart';
import 'package:uq_system_app/presentation/pages/dashboard/dashboard_state.dart';

class DashboardSelector<T>
    extends BlocSelector<DashboardBloc, DashboardState, T> {
  DashboardSelector(
      {required Widget Function(T data) builder, required super.selector})
      : super(
    builder: (_, data) => builder(data),
  );
}