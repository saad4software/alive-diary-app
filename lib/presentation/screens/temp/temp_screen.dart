import 'dart:io';

import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:alive_diary/presentation/blocs/list/list_bloc.dart';
import 'package:alive_diary/presentation/screens/temp/temp_bloc.dart';
import 'package:alive_diary/presentation/widgets/app_list_widget.dart';
import 'package:alive_diary/presentation/widgets/item_diary.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


@RoutePage()
class TempScreen extends HookWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TempBloc>(context);
    final listBloc = BlocProvider.of<ListBloc<DiaryModel>>(context);


    useEffect(() {


      return null;
    }, []);

    return LayoutWidget(
      title: "Temp screen",
      child: Container(

        child: BlocBuilder<ListBloc<DiaryModel>, ListState<DiaryModel>>(
          builder: (context, state) {

            return AppListWidget<DiaryModel>(
              list: state.list,
              isLoading: state is ListLoadingState,
              getPageDate: () => listBloc.add(ListGetEvent()),
              buildItem: (item)=>ItemDiary(item: item!),
              noMoreData: state.noMoreData ?? true,
              onRefresh: ()=>listBloc.add(ListRefreshEvent()),
            );

          },
        ),
      ),
    );
  }
}
