import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/presentation/screens/profile_edit/profile_edit_bloc.dart';
import 'package:alive_diary/presentation/widgets/app_field_widget.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:alive_diary/presentation/widgets/loading_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:oktoast/oktoast.dart';


@RoutePage()
class ProfileEditScreen extends HookWidget {
  const ProfileEditScreen({this.user, super.key});


  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProfileEditBloc>(context);


    final emailField = useTextEditingController(text: user?.username);
    final firstNameField = useTextEditingController(text: user?.firstName);
    final lastNameField = useTextEditingController(text: user?.lastName);
    final bioField = useTextEditingController(text: user?.bio);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    return BlocListener<ProfileEditBloc, ProfileEditState>(
      listener: (context, state) {
        if (state is ProfileEditSuccessState) {
          showToast("Profile updated successfully");
          appRouter.back();
        }
      },
      child: LayoutWidget(
        title: "Edit Profile",
        child: SingleChildScrollView(
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
                    label: AppLocale.email,
                    isEnabled: false,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: firstNameField,
                    label: AppLocale.firstName.getString(context),
                    isRequired: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  AppFieldWidget(
                    controller: lastNameField,
                    label: AppLocale.lastName.getString(context),
                    isRequired: true,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  AppFieldWidget(
                    controller: bioField,
                    label: AppLocale.bio.getString(context),
                    isMultiline: true,
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
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      BlocBuilder<ProfileEditBloc, ProfileEditState>(
                        builder: (context, state) {
                          return state is ProfileEditLoadingState ?
                          const LoadingWidget() :
                          ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                bloc.add(ProfileEditUpdateEvent(
                                  firstName: firstNameField.text,
                                  lastName: lastNameField.text,
                                  bio: bioField.text,
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
                              child: Text(AppLocale.save.getString(context),
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
