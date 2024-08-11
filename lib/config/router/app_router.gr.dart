// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ConfirmRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConfirmScreen(),
      );
    },
    ConversationRoute.name: (routeData) {
      final args = routeData.argsAs<ConversationRouteArgs>(
          orElse: () => const ConversationRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ConversationScreen(
          key: args.key,
          item: args.item,
          type: args.type,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LibraryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LibraryScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainNavRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainNavScreen(),
      );
    },
    ProfileEditRoute.name: (routeData) {
      final args = routeData.argsAs<ProfileEditRouteArgs>(
          orElse: () => const ProfileEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ProfileEditScreen(
          user: args.user,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
  };
}

/// generated route for
/// [ConfirmScreen]
class ConfirmRoute extends PageRouteInfo<void> {
  const ConfirmRoute({List<PageRouteInfo>? children})
      : super(
          ConfirmRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ConversationScreen]
class ConversationRoute extends PageRouteInfo<ConversationRouteArgs> {
  ConversationRoute({
    Key? key,
    DiaryModel? item,
    ConversationType? type,
    List<PageRouteInfo>? children,
  }) : super(
          ConversationRoute.name,
          args: ConversationRouteArgs(
            key: key,
            item: item,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'ConversationRoute';

  static const PageInfo<ConversationRouteArgs> page =
      PageInfo<ConversationRouteArgs>(name);
}

class ConversationRouteArgs {
  const ConversationRouteArgs({
    this.key,
    this.item,
    this.type,
  });

  final Key? key;

  final DiaryModel? item;

  final ConversationType? type;

  @override
  String toString() {
    return 'ConversationRouteArgs{key: $key, item: $item, type: $type}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LibraryScreen]
class LibraryRoute extends PageRouteInfo<void> {
  const LibraryRoute({List<PageRouteInfo>? children})
      : super(
          LibraryRoute.name,
          initialChildren: children,
        );

  static const String name = 'LibraryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainNavScreen]
class MainNavRoute extends PageRouteInfo<void> {
  const MainNavRoute({List<PageRouteInfo>? children})
      : super(
          MainNavRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainNavRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileEditScreen]
class ProfileEditRoute extends PageRouteInfo<ProfileEditRouteArgs> {
  ProfileEditRoute({
    UserModel? user,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ProfileEditRoute.name,
          args: ProfileEditRouteArgs(
            user: user,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ProfileEditRoute';

  static const PageInfo<ProfileEditRouteArgs> page =
      PageInfo<ProfileEditRouteArgs>(name);
}

class ProfileEditRouteArgs {
  const ProfileEditRouteArgs({
    this.user,
    this.key,
  });

  final UserModel? user;

  final Key? key;

  @override
  String toString() {
    return 'ProfileEditRouteArgs{user: $user, key: $key}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
