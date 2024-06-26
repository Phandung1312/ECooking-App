
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/account.item.dart';
import 'package:uq_system_app/presentation/pages/follow/widgets/member.item.dart';

import '../../../../../domain/entities/enum/enum.dart';
import '../../../../../domain/entities/params/search.params.dart';
import '../search_bloc.dart';
import '../search_event.dart';
import '../search_selector.dart';

class AccountTab extends StatefulWidget {
  final SearchBloc bloc;
  final int? accountId;
  const AccountTab({
    Key? key, required this.bloc, this.accountId,
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
          selector: (state) => state.searchResult.members,
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) =>
                     MemberItem(member: data[index], onFollow: (isFollow) {

                     }, isMe: widget.accountId == data[index].id,),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: 10);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
