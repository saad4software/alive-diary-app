import 'package:alive_diary/config/extension/scroll_view_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppListWidget<T> extends HookWidget {
  const AppListWidget({
    super.key,
    this.getPageDate,
    this.onRefresh,
    this.buildItem,
    this.list,
    this.noMoreData = true,
    this.isLoading = false,

  });

  final Function()? getPageDate;
  final Function()? onRefresh;
  final Function(T?)? buildItem;
  final List<T>? list;

  final bool noMoreData;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {

    final scrollController = useScrollController();


    useEffect(() {

      scrollController.onScrollEndsListener(() {
        getPageDate?.call();
      });
      getPageDate?.call();

      return null;
    }, []);

    return RefreshIndicator(
      backgroundColor: Colors.white,
      onRefresh: () async {
        onRefresh?.call();
      },
      child: Container(
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) =>buildItem?.call(list?[index]),
                childCount: list?.length ?? 0,
              ),
            ),
            if (!noMoreData || isLoading)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 32),
                  child: CupertinoActivityIndicator(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
