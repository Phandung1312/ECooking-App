import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/di/injector.dart';

import 'create_recipe_bloc.dart';



@RoutePage()
class CreateRecipePage extends StatefulWidget {
  @override
  State<CreateRecipePage> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
final CreateRecipeBloc _bloc = getIt.get<CreateRecipeBloc>();
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
          title: const Text('Create Recipe Page'),
        ),
        body: const Center(
          child: Text('Create Recipe Page'),
        ),
      ),
    );
  }
}
