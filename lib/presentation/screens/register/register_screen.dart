import 'package:alive_diary/config/extension/dio_exception_extension.dart';
import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/presentation/screens/register/register_bloc.dart';
import 'package:alive_diary/presentation/widgets/app_field_widget.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:alive_diary/presentation/widgets/loading_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class RegisterScreen extends HookWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<RegisterBloc>(context);

    final emailField = useTextEditingController(text: "");
    final passwordField = useTextEditingController(text: "");
    final confirmField = useTextEditingController(text: "");
    final firstNameField = useTextEditingController(text: "");
    final lastNameField = useTextEditingController(text: "");

    final formKey = useMemoized(GlobalKey<FormState>.new);

    return LayoutWidget(
      title: AppLocale.register.getString(context),
      child: SingleChildScrollView(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              showToast("Registered successfully");
              appRouter.push( ConfirmRoute(user: state.user));
            } else if (state is RegisterErrorState) {
              showToast(state.error?.getErrorMessage() ?? "Check your email for code");
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: emailField,
                    label: AppLocale.email.getString(context),
                    inputType: TextInputType.emailAddress,
                  ),


                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: passwordField,
                    label: AppLocale.password.getString(context),
                    isPassword: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: confirmField,
                    label: AppLocale.confirmPassword.getString(context),
                    isPassword: true,
                  ),


                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: firstNameField,
                    label: AppLocale.firstName.getString(context),
                  ),


                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: lastNameField,
                    label: AppLocale.lastName.getString(context),
                  ),


                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 10,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          appRouter.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.grey, // This is what you need!
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            AppLocale.cancel.getString(context),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return state is RegisterLoadingState
                              ? ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Colors.green, // This is what you need!
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: const LoadingWidget(color: Colors.white,),
                                )
                              )
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(RegisterClickedEvent(
                                        firstName: firstNameField.text,
                                        lastName: lastNameField.text,
                                        email: emailField.text,
                                        password: passwordField.text,
                                        confirm: confirmField.text,
                                      ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green, // This is what you need!
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(AppLocale.register.getString(context),
                                        style: const TextStyle(color: Colors.white)),
                                  ),
                                );
                        },
                      ),
                    ],
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
