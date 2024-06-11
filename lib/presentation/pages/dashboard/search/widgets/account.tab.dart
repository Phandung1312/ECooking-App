import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/account.item.dart';

import '../../../../../di/injector.dart';
import '../../../../../domain/entities/enum/enum.dart';
import '../../../../../domain/entities/params/search.params.dart';
import '../search_bloc.dart';
import '../search_event.dart';
import '../search_selector.dart';

class AccountTab extends StatefulWidget {
  final SearchBloc bloc;
  const AccountTab({
    Key? key, required this.bloc,
  }) : super(key: key);

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {

  void _onLoad() async {
    widget.bloc.add(SearchGetResult(
      params: SearchParams(
        type: SearchType.account,
        title: widget.bloc.state.currentQuery,
        page: widget.bloc.state.currentAccountPage,
      ),
      isRefresh: false,
    ));
  }
  @override
  void initState() {
    widget.bloc.accountController = RefreshController();
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SmartRefresher(
        physics: const ClampingScrollPhysics(),
        onLoading: _onLoad,
        enablePullDown: false,
        enablePullUp: true,
        controller: widget.bloc.accountController,
        child: SearchSelector(
          selector: (state) => state.searchResult.accounts,
          builder: (data) {
            if(data.isEmpty){
              return const Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text('Không tìm thấy kết quả phù hợp'),
                ],
              );
            }else {
              return ListView.separated(
                itemCount: data.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) =>
                    AccountItem(
                      account: data[index],
                    ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 10);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
