import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uq_system_app/di/injector.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/search_bloc.dart';



@RoutePage()
class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
final SearchBloc _bloc = getIt.get<SearchBloc>();
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
          title: const Text('Search Page'),
        ),
        body: const Center(
          child: Text('Search Page'),
        ),
      ),
    );
  }
}
