import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/domain/models/responses/ErrorResponse.dart';
import 'package:alive_diary/presentation/screens/confirm/confirm_bloc.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:alive_diary/presentation/widgets/loading_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oktoast/oktoast.dart';

@RoutePage()
class ConfirmScreen extends HookWidget {
  const ConfirmScreen({
    super.key,
    this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ConfirmBloc>(context);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final usernameField = useTextEditingController(text: user?.username ?? "");
    final codeField = useTextEditingController(text: "");

    return LayoutWidget(
      title: AppLocale.confirmAccount.getString(context),
      child: SingleChildScrollView(
        child: BlocListener<ConfirmBloc, ConfirmState>(
          listener: (context, state) {
            if (state is ConfirmSuccessState) {
              showToast("Activated account successfully");
              appRouter
                  .popUntil((route) => route.settings.name == LoginRoute.name);
            } else if (state is ConfirmErrorState) {
              final msg = state.error?.response?.data == null
                  ? state.error?.message
                  : ErrorResponse.fromJson(state.error?.response?.data)
                      .message
                      ?.trim();

              showToast(msg ?? "Something went wrong");
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
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameField,
                    validator: (val) => val!.isEmpty ? AppLocale.required.getString(context) : null,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: AppLocale.email.getString(context),
                      labelStyle: const TextStyle(color: Colors.black38),
                      floatingLabelStyle:
                          const TextStyle(height: 4, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(width: 2),
                      ),
                      filled: true,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: codeField,
                    validator: (val) => val!.isEmpty ? AppLocale.required.getString(context) : null,
                    decoration: InputDecoration(
                      labelText: AppLocale.code.getString(context),
                      labelStyle: const TextStyle(color: Colors.black38),
                      floatingLabelStyle:
                          const TextStyle(height: 4, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(width: 2),
                      ),
                      filled: true,
                    ),
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
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      BlocBuilder<ConfirmBloc, ConfirmState>(
                        builder: (context, state) {
                          return state is ConfirmLoadingState
                              ? ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: const LoadingWidget(
                                      color: Colors.white,
                                    ),
                                  ))
                              : ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      bloc.add(ConfirmClickedEvent(
                                        email: usernameField.text,
                                        code: codeField.text,
                                      ));
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(AppLocale.confirm.getString(context),
                                        style: TextStyle(color: Colors.white)),
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
