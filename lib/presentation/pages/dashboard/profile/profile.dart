import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/profile/profile_bloc.dart';



@RoutePage()
class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
final ProfileBloc _bloc = getIt.get<ProfileBloc>();
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
          title: const Text('Profile Page'),
        ),
        body: const Center(
          child: Text('Profile Page'),
        ),
      ),
    );
  }
}
