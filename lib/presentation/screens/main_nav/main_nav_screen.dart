import 'dart:io';
import 'dart:ui';

import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


@RoutePage()
class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        LibraryRoute(),
        ProfileRoute(),
      ],

      appBarBuilder: (context, router)=>AppBar(
        title: Text(router.current.title(context).getString(context)),
        leading: Container(
            padding: const EdgeInsets.all(5),
            child: Container(
              padding: const EdgeInsets.all(5),
                child:Image.asset("assets/images/diary_new.png"),
            )),
        actions: [
          IconButton(
            onPressed: (){

              GetIt.instance<SharedPreferences>().setString(
                AppConsts.keyToken,
                "",
              );
              sleep(const Duration(milliseconds: 100));
              exit(0);
            },
            icon: const Icon(Icons.lock),
          )
        ],

      ),


      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white54,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppLocale.home.getString(context)),
            BottomNavigationBarItem(icon: const Icon(Icons.menu_book_sharp), label: AppLocale.library.getString(context)),
            BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppLocale.profile.getString(context)),
          ],
        );
      },
    );

  }




}
