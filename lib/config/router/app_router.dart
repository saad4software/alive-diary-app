import 'package:alive_diary/config/constants/app_consts.dart';
import 'package:alive_diary/domain/models/entities/diary_model.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/presentation/screens/confirm/confirm_screen.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_screen.dart';
import 'package:alive_diary/presentation/screens/home/home_screen.dart';
import 'package:alive_diary/presentation/screens/library/library_screen.dart';
import 'package:alive_diary/presentation/screens/login/login_screen.dart';
import 'package:alive_diary/presentation/screens/main_nav/main_nav_screen.dart';
import 'package:alive_diary/presentation/screens/profile/profile_screen.dart';
import 'package:alive_diary/presentation/screens/profile_edit/profile_edit_screen.dart';
import 'package:alive_diary/presentation/screens/register/register_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_router.gr.dart';



@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  var token = GetIt.instance<SharedPreferences>().getString(
    AppConsts.keyToken,
  );
  get hasExpired => (String? token) {
    return (token == null || token.isEmpty) || JwtDecoder.isExpired(token);
  };

  @override
  List<AutoRoute> get routes => [

    AutoRoute(
        page: MainNavRoute.page,
        initial: !hasExpired(token),
        children: [
          AutoRoute(page: HomeRoute.page, title: (context, data)=>"home"),
          AutoRoute(page: LibraryRoute.page,title: (context, data)=>"library"),
          AutoRoute(page: ProfileRoute.page,title: (context, data)=>"profile"),

        ],
  ),

    AutoRoute(
        initial: hasExpired(token),
        page: LoginRoute.page,
        title: (context, data)=>"profile"
    ),

    AutoRoute(
        initial: false,
        page: RegisterRoute.page,
    ),

    AutoRoute(
        initial: false,
        page: ConfirmRoute.page,
    ),

    AutoRoute(
        initial: false,
        page: ProfileEditRoute.page,
    ),

    AutoRoute(
        initial: false,
        page: ConversationRoute.page,
    ),

    // AutoRoute(
    //   page: ChildRoute.page,
    //   title: (context, data)=>"child",
    //   guards: [AuthGuard()],
    // ),

  ];
}

final appRouter = AppRouter();
