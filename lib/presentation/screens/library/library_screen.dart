import 'package:alive_diary/config/extension/dio_exception_extension.dart';
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
import 'package:oktoast/oktoast.dart';

@RoutePage()
class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LibraryBloc>(context);

    final diariesScrollController = useScrollController();
    final memoriesScrollController = useScrollController();
    final tabController = useTabController(initialLength: 2, initialIndex: 0);

    final userEmailController = useTextEditingController();


    tabController.addListener(() {
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


    return BlocListener<LibraryBloc, LibraryState>(
      listener: (context, state) {
        switch (state) {

          case LibraryInitial():
            // TODO: Handle this case.
            break;
          case LibraryLoadingState():
            // TODO: Handle this case.
            break;
          case LibraryShareDiaryState():
            showToast(state.errorMessage ?? "Diary shared successfully");
          case LibraryShareMemoryState():
            showToast(state.errorMessage ?? "Memory shared successfully");
          case LibraryDeleteDiaryState():
            showToast(state.errorMessage ?? "Diary deleted successfully");
          case LibraryDeleteMemoryState():
            showToast(state.errorMessage ?? "Memory shared successfully");
          case LibraryDiariesState():
            break;
          case LibraryMemoriesState():
            break;
          case LibraryErrorState():
            showToast(state.errorMessage ?? "Unexpected error");
        }

      },
      child: Column(
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
                    buildWhen: (previous,
                        current) => current is LibraryMemoriesState,
                    builder: (context, state) {
                      switch (state) {
                        case LibraryInitial():
                        // TODO: Handle this case.
                        case LibraryLoadingState():
                          return const Center(
                              child: CupertinoActivityIndicator());
                        case LibraryDiariesState():
                        // TODO: Hand
                        case LibraryShareDiaryState():
                        // TODO: Handle this case.
                        case LibraryShareMemoryState():
                        // TODO: Handle this case.
                        case LibraryDeleteDiaryState():
                        // TODO: Handle this case.
                        case LibraryDeleteMemoryState():
                        // TODO: Handle this case.
                        case LibraryMemoriesState():
                          return buildMemoriesList(
                            context,
                            userEmailController,
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
                    buildWhen: (previous,
                        current) => current is LibraryDiariesState,
                    builder: (context, state) {
                      switch (state) {
                        case LibraryInitial():
                        // TODO: Handle this case.
                        case LibraryLoadingState():
                          return const Center(
                              child: CupertinoActivityIndicator());
                        case LibraryMemoriesState():
                          return const SizedBox();

                        case LibraryErrorState():
                          return Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(state.errorMessage ?? "no error msg"),
                          );
                        case LibraryShareDiaryState():
                        // TODO: Handle this case.
                        case LibraryShareMemoryState():
                        // TODO: Handle this case.
                        case LibraryDeleteDiaryState():
                        // TODO: Handle this case.
                        case LibraryDeleteMemoryState():
                        // TODO: Handle this case.

                        case LibraryDiariesState():
                          return buildDiariesList(
                            context,
                            userEmailController,
                            diariesScrollController,
                            state.diariesList,
                            state.noMoreDiaries,
                          );
                      }
                    },
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Widget buildDiariesList(BuildContext context,
      TextEditingController controller,
      ScrollController scrollController,
      List<DiaryModel> list,
      bool noMoreData,) {
    final bloc = BlocProvider.of<LibraryBloc>(context);


    void showShareDialog(DiaryModel item) {
      final dialog = AlertDialog(
        title: const Text('User email:'),
        content: Form(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "alex@gmail.com",
              hintStyle: const TextStyle(color: Colors.black38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(width: 2),
              ),
              filled: true,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              bloc.add(LibraryShareDiaryEvent(
                email: controller.text,
                item: item,
              ));

              controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Share'),
          ),
        ],
      );

      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: dialog,
                // AlertDialog(
                //   shape: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(16.0)),
                //   title: Text('Hello!!'),
                //   content: Text('How are you?'),
                // ),

              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          });
    }


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
                  onShare: (item) => showShareDialog(item),
                  showContextMenu: true,
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

  Widget buildMemoriesList(
      BuildContext context,
      TextEditingController controller,
      ScrollController scrollController,
      List<DiaryModel> list,
      bool noMoreData,) {

    final bloc = BlocProvider.of<LibraryBloc>(context);

    void showShareDialog(DiaryModel item) {
      final dialog = AlertDialog(
        title: const Text('User email:'),
        content: Form(
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "alex@gmail.com",
              hintStyle: const TextStyle(color: Colors.black38),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(width: 2),
              ),
              filled: true,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              bloc.add(LibraryShareMemoryEvent(
                email: controller.text,
                item: item,
              ));

              controller.clear();
              Navigator.pop(context);
            },
            child: const Text('Share'),
          ),
        ],
      );

      showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          transitionBuilder: (context, a1, a2, widget) {
            final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
            return Transform(
              transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
              child: Opacity(
                opacity: a1.value,
                child: dialog,
                // AlertDialog(
                //   shape: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(16.0)),
                //   title: Text('Hello!!'),
                //   content: Text('How are you?'),
                // ),

              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          barrierDismissible: true,
          barrierLabel: '',
          context: context,
          pageBuilder: (context, animation1, animation2) {
            return Container();
          });
    }


    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) =>
                ItemDiary(
                  item: list[index],
                  showContextMenu: true,
                  onItemPressed: (item) {
                    appRouter.push(ConversationRoute(
                      item: item,
                      type: ConversationType.memory,
                    ));
                  },
                  onShare: (item) {
                    showShareDialog(item);
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
