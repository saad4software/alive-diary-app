import 'package:alive_diary/abstracts/bloc_observer.dart';
import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/config/theme/app_theme.dart';
import 'package:alive_diary/domain/repositories/api_repository.dart';
import 'package:alive_diary/presentation/blocs/list/list_bloc.dart';
import 'package:alive_diary/presentation/screens/confirm/confirm_bloc.dart';
import 'package:alive_diary/presentation/screens/conversation/conversation_bloc.dart';
import 'package:alive_diary/presentation/screens/library/library_bloc.dart';
import 'package:alive_diary/presentation/screens/login/login_bloc.dart';
import 'package:alive_diary/presentation/screens/profile/profile_bloc.dart';
import 'package:alive_diary/presentation/screens/profile_edit/profile_edit_bloc.dart';
import 'package:alive_diary/presentation/screens/register/register_bloc.dart';
import 'package:alive_diary/presentation/screens/temp/temp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oktoast/oktoast.dart';

import 'presentation/screens/home/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await diInit();
  Bloc.observer = Observer();

  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final localization = locator<FlutterLocalization>();
    final currentLocale = useState(localization.currentLocale.localeIdentifier);
    localization.onTranslatedLanguage = (locale){
      currentLocale.value = locale.localeIdentifier;
    };

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc(locator(), locator(), locator(), locator(), locator())),
          BlocProvider(create: (context) => ConversationBloc(locator(), locator(), locator(), locator())),
          BlocProvider(create: (context) => LoginBloc(locator(), locator())),
          BlocProvider(create: (context) => RegisterBloc(locator())),
          BlocProvider(create: (context) => ConfirmBloc(locator())),
          BlocProvider(create: (context) => LibraryBloc(locator())),
          BlocProvider(create: (context) => ProfileBloc(locator())),
          BlocProvider(create: (context) => ProfileEditBloc(locator(), locator())),

          BlocProvider(create: (context) => TempBloc(locator())),  // for testing purposes

        ],

        child: OKToast(
            position: ToastPosition.bottom,
            child: MaterialApp.router(
              theme: AppTheme.light,
              locale: Locale(currentLocale.value),
              supportedLocales: locator<FlutterLocalization>().supportedLocales,
              localizationsDelegates: locator<FlutterLocalization>().localizationsDelegates,
              routerConfig: appRouter.config(),
              debugShowCheckedModeBanner: false,

            )
        )
    );
  }
}
