import 'package:alive_diary/config/extension/scroll_view_extensions.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_screen.dart';
import 'package:alive_diary/presentation/screens/library/library_bloc.dart';
import 'package:alive_diary/presentation/widgets/item_diary.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LibraryBloc>(context);

    final diariesScrollController = useScrollController();
    final memoriesScrollController = useScrollController();
    final tabController = useTabController(initialLength: 2, initialIndex: 0);


    tabController.addListener((){
      if (tabController.index == 1) bloc.add(const LibraryDiariesListEvent());
      if (tabController.index == 0) bloc.add(const LibraryMemoriesListEvent());
    });

    useEffect(() {
      diariesScrollController.onScrollEndsListener(() {
        bloc.add(const LibraryDiariesListEvent());
      });

      memoriesScrollController.onScrollEndsListener(() {
        bloc.add(const LibraryMemoriesListEvent());
      });

      bloc.add(const LibraryMemoriesListEvent());

      return null;
    }, []);

    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              child: Text(
                "Memories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Tab(
              child: Text(
                "Diaries",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
        ),
        Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                BlocBuilder<LibraryBloc, LibraryState>(
                  buildWhen: (previous, current) => current is LibraryMemoriesState,
                  builder: (context, state) {
                    switch (state) {

                      case LibraryInitial():
                        // TODO: Handle this case.
                      case LibraryLoadingState():
                        return const Center(child: CupertinoActivityIndicator());
                      case LibraryDiariesState():
                        // TODO: Hand
                      case LibraryMemoriesState():
                        return buildMemoriesList(
                          memoriesScrollController,
                          state.memoriesList,
                          state.noMoreMemories,
                        );
                      case LibraryErrorState():
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(state.errorMessage ?? "no error msg"),
                        );
                    }

                  },
                ),

                BlocBuilder<LibraryBloc, LibraryState>(
                  buildWhen: (previous, current) => current is LibraryDiariesState,
                  builder: (context, state) {

                    switch (state) {

                      case LibraryInitial():
                      // TODO: Handle this case.
                      case LibraryLoadingState():
                        return const Center(child: CupertinoActivityIndicator());
                      case LibraryDiariesState():
                          return buildDiariesList(
                            diariesScrollController,
                            state.diariesList,
                            state.noMoreDiaries,
                          );
                      case LibraryMemoriesState():
                        return const SizedBox();

                      case LibraryErrorState():
                        return Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(state.errorMessage ?? "no error msg"),
                        );
                    }

                  },
                ),
              ],
            ))
      ],
    );
  }

  Widget buildDiariesList(ScrollController scrollController,
      List<DiaryModel> list,
      bool noMoreData,) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) =>
                ItemDiary(
                  item: list[index],
                  onItemPressed: (item) {
                    appRouter.push(ConversationRoute(
                      item: item,
                      type: ConversationType.diary,
                    ));
                  },
                ),
            childCount: list.length,
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 32),
              child: CupertinoActivityIndicator(),
            ),
          )
      ],
    );
  }

  Widget buildMemoriesList(ScrollController scrollController,
      List<DiaryModel> list,
      bool noMoreData,) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) =>
                ItemDiary(
                  item: list[index],
                  onItemPressed: (item) {
                    appRouter.push(ConversationRoute(
                      item: item,
                      type: ConversationType.memory,
                    ));
                  },
                ),
            childCount: list.length,
          ),
        ),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 32),
              child: CupertinoActivityIndicator(),
            ),
          )
      ],
    );
  }
}
