import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/account/account_bloc.dart';

@RoutePage()
class DashboardAccountPage extends StatefulWidget {
  @override
  State<DashboardAccountPage> createState() => _DashboardAccountPageState();
}

class _DashboardAccountPageState extends State<DashboardAccountPage> {
  final AccountBloc _bloc = provider.get<AccountBloc>();

  @override
  void dispose() {
    _bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Account Page'),
        ),
        body: const Center(
          child: Text('Account Page'),
        ),
      ),
    );
  }
}
