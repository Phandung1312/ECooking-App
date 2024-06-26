import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uq_system_app/presentation/pages/dashboard/search/widgets/instruction.item.dart';

import '../../../../../domain/entities/enum/enum.dart';
import '../../../../../domain/entities/params/search.params.dart';
import '../search_bloc.dart';
import '../search_event.dart';
import '../search_selector.dart';

class InstructionTab extends StatefulWidget {
  final SearchBloc bloc;
  const InstructionTab({Key? key, required this.bloc}) : super(key: key);

  @override
  State<InstructionTab> createState() => _InstructionTabState();
}

class _InstructionTabState extends State<InstructionTab> {
  void _onLoad() async {
    widget.bloc.add(SearchGetResult(
      params: SearchParams(
        type: SearchType.instruction,
        title: widget.bloc.state.currentQuery,
        page: widget.bloc.state.currentInstructionPage,
      ),
      isRefresh: false,
    ));
  }
  @override
  void initState() {
    widget.bloc.instructionController = RefreshController();
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
        controller: widget.bloc.instructionController,
        child: SearchSelector(
          selector: (state) => state.searchResult.instructions,
          builder: (data) {
            if (data.isEmpty) {
              return const Column(
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text('Không tìm thấy kết quả phù hợp'),
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: ListView.separated(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) => InstructionItem(
                    instruction: data[index],
                  ),
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
