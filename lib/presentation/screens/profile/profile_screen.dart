import 'package:alive_diary/config/di/locator.dart';
import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/config/theme/app_theme.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/presentation/screens/profile/profile_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';

@RoutePage()
class ProfileScreen extends HookWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileBloc>(context);
      // ..add(ProfileLoadEvent());

    final selectedLanguage = useState("EN");
    final profile = useState<UserModel?>(null);


    useEffect((){
      bloc.add(ProfileLoadEvent());
      return null;
    }, []);

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          profile.value = state.user;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        child: Column(
          children: [
            TextButton(
              onPressed: (){
                appRouter.push(ProfileEditRoute(user: profile.value));
              },
              child: SizedBox(
                height: 200,
                child: Image.asset("assets/images/diary_icon.png",),
              ),
            ),
            Text("${profile.value?.firstName} ${profile.value?.lastName}", style: AppTheme.textHeader,),
            Text("${profile.value?.username}", style: AppTheme.textBody,),
            // Text("${profile.value?.bio}", style: AppTheme.textBody,),

            GestureDetector(
              onTap: () {
                final dialog = AlertDialog(
                  title: const Text('Select Language'),
                  backgroundColor: Colors.white,
                  actions: [
                    TextButton(
                      onPressed: () {
                        selectedLanguage.value = "EN";
                        locator<FlutterLocalization>().translate("en");
                        Navigator.pop(context);
                      },
                      child: const Text('English'),
                    ),
                    TextButton(
                      onPressed: () {
                        selectedLanguage.value = "AR";
                        locator<FlutterLocalization>().translate("ar");
                        Navigator.pop(context);
                      },
                      child: const Text('Arabic'),
                    ),
                  ],
                );

                showDialog(context: context, builder: (context) => dialog);
              },
              child: Card(
                color: Colors.white38,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  width: double.infinity,
                  height: 75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocale.language.getString(context),
                        style: AppTheme.textHeader,),
                      Text(selectedLanguage.value),
                    ],
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
