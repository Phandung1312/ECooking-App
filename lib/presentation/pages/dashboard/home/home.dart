import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/core/extensions/theme.dart';
import 'package:uq_system_app/core/languages/translation_keys.g.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/home/home_bloc.dart';
import 'package:uq_system_app/presentation/widgets/header_item.dart';
import 'package:uq_system_app/presentation/widgets/search_field.dart';

import 'home_event.dart';
import 'home_state.dart';

@RoutePage()
class DashboardHomePage extends StatefulWidget {
  const DashboardHomePage({super.key});

  @override
  State<DashboardHomePage> createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  final HomeBloc _bloc = provider.get<HomeBloc>();

  Future _onRefresh() async {
    _bloc.add(const HomeRefreshData());
    return _bloc.stream
        .firstWhere((state) => state.status != HomeStatus.refreshing);
  }

  @override
  void initState() {
    scheduleMicrotask(() {
      _bloc.add(const DashboardHomeGetDataStarted());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: CustomScrollView(
          slivers: [],
        ),
      ),
    );
  }
}
