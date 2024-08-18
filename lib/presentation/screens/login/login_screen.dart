import 'dart:io';

import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/presentation/screens/login/login_bloc.dart';
import 'package:alive_diary/presentation/widgets/app_field_widget.dart';
import 'package:alive_diary/presentation/widgets/loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oktoast/oktoast.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class LoginScreen extends HookWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<LoginBloc>(context);


    final usernameField = useTextEditingController(text: "");
    final passwordField = useTextEditingController(text: "");

    final formKey = useMemoized(GlobalKey<FormState>.new);

    useEffect((){
      bloc.add(LoginInitEvent());
      return null;
    }, []);

    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {

            showToast(state.errorMessage ?? "Something went wrong");
          } else if (state is LoginSuccessState) {
            showToast(AppLocale.welcome.getString(context));
            appRouter.replaceAll([const MainNavRoute()]);
          } else if (state is LoginInitialState) {
            if (state.isLoggedIn) appRouter.replaceAll([const MainNavRoute()]);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(onPressed: () {
                        // SystemNavigator.pop(animated: true);
                        exit(0);
                      }, icon: const Icon(Icons.close)),
                    ],
                  ),

                  Lottie.asset('assets/lottie/profile.json'),

                  AppFieldWidget(
                    controller: usernameField,
                    label: AppLocale.email.getString(context),
                    isRequired: true,
                    inputType: TextInputType.emailAddress,
                  ),


                  const SizedBox(height: 20,),

                  AppFieldWidget(
                    controller: passwordField,
                    label: AppLocale.password.getString(context),
                    isRequired: true,
                    isPassword: true,
                  ),

                  const SizedBox(height: 20,),

                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return state is LoginLoadingState ?

                      const LoadingWidget() :
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .green, // This is what you need!
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            bloc.add(
                                LoginPressedEvent(
                                    username: usernameField.text,
                                    password: passwordField.text
                                )
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(AppLocale.login.getString(context),
                            style: const TextStyle(color: Colors.white),),
                        ),
                      );
                    },
                  ),

                  TextButton(

                    onPressed: () {
                      appRouter.push(const RegisterRoute());
                    },
                    child: Text(AppLocale.noAccount.getString(context)),
                  ),

                  TextButton(

                    onPressed: () {
                      appRouter.push( ConfirmRoute());
                    },
                    child: Text(AppLocale.haveCode.getString(context)),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
