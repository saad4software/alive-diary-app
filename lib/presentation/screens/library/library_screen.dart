import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/memory_model.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:alive_diary/presentation/blocs/list/list_bloc.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_screen.dart';
import 'package:alive_diary/presentation/screens/library/library_bloc.dart';
import 'package:alive_diary/presentation/widgets/app_list_widget.dart';
import 'package:alive_diary/presentation/widgets/item_diary.dart';
import 'package:alive_diary/presentation/widgets/item_memory.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class LibraryScreen extends HookWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<LibraryBloc>(context);
    final memoriesBloc = BlocProvider.of<ListBloc<MemoryModel>>(context);
    final diariesBloc = BlocProvider.of<ListBloc<DiaryModel>>(context);

    final tabController = useTabController(initialLength: 2, initialIndex: 0);

    final userEmailController = useTextEditingController();


    useEffect(() {

      return null;
    }, []);


    void showShareDialog({DiaryModel? diary, MemoryModel? memory}) {
      final dialog = AlertDialog(
        title: Text(AppLocale.userEmail.getString(context)),
        content: Form(
          child: TextFormField(
            controller: userEmailController,
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
            child: Text(AppLocale.cancel.getString(context)),
          ),
          TextButton(
            onPressed: () {

              if (memory != null) {
                bloc.add(LibraryShareMemoryEvent(
                  email: userEmailController.text,
                  memory: memory,
                ));
              } else if (diary != null) {
                bloc.add(LibraryShareDiaryEvent(
                  email: userEmailController.text,
                  diary: diary,
                ));
              }



              userEmailController.clear();
              Navigator.pop(context);
            },
            child: Text(AppLocale.share.getString(context)),
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

    void showDeleteDialog(MemoryModel item) {
      final dialog = AlertDialog(
        title: Text(AppLocale.areYouSure.getString(context)),
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(AppLocale.cancel.getString(context)),
          ),
          TextButton(
            onPressed: () async {
              bloc.add(LibraryDelMemoryEvent(memory: item));
              Navigator.pop(context);
            },
            child: Text(AppLocale.delete.getString(context)),
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
            diariesBloc.add(ListRefreshEvent());
          case LibraryDeleteMemoryState():
            showToast(state.errorMessage ?? "Memory deleted successfully");
            memoriesBloc.add(ListRefreshEvent());
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
            tabs: [
              Tab(
                child: Text(
                  AppLocale.memories.getString(context),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
              Tab(
                child: Text(
                  AppLocale.diaries.getString(context),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ],
          ),
          Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  BlocBuilder<ListBloc<MemoryModel>, ListState<MemoryModel>>(
                    builder: (context, state) {

                      return AppListWidget<MemoryModel>(
                        list: state.list,
                        isLoading: state is ListLoadingState,
                        getPageDate: () => memoriesBloc.add(ListGetEvent()),
                        buildItem: (item)=>ItemMemory(
                          item: item!,
                          showContextMenu: true,
                          onShare: (item)=>showShareDialog(memory: item),
                          onRemove: showDeleteDialog,
                          onItemPressed: (item)=>appRouter.push(ConversationRoute(
                            memory: item,
                            type: ConversationType.memory,
                          )),
                        ),
                        noMoreData: state.noMoreData ?? true,
                        onRefresh: ()=>memoriesBloc.add(ListRefreshEvent()),
                      );
                    },


                  ),

                  BlocBuilder<ListBloc<DiaryModel>, ListState<DiaryModel>>(
                    builder: (context, state) {

                      return AppListWidget<DiaryModel>(
                        list: state.list,
                        isLoading: state is ListLoadingState,
                        getPageDate: () => diariesBloc.add(ListGetEvent()),
                        buildItem: (item)=>ItemDiary(
                          item: item!,
                          showContextMenu: true,
                          onShare: (item)=>showShareDialog(diary: item),
                          // onRemove: showDeleteDialog,
                          onItemPressed: (item)=>appRouter.push(ConversationRoute(
                            diary: item,
                            type: ConversationType.diary,
                          )),
                        ),
                        noMoreData: state.noMoreData ?? true,
                        onRefresh: ()=>diariesBloc.add(ListRefreshEvent()),
                      );
                    },


                  ),
                ],
              ))
        ],
      ),
    );
  }


}
