import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/entities/user_model.dart';
import 'package:alive_diary/presentation/widgets/app_form_field.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


@RoutePage()
class ProfileEditScreen extends HookWidget {
  const ProfileEditScreen({this.user, super.key});


  final UserModel? user;

  @override
  Widget build(BuildContext context) {

    final emailField = useTextEditingController(text: user?.username);
    final firstNameField = useTextEditingController(text: user?.firstName);
    final lastNameField = useTextEditingController(text: user?.lastName);
    final bioField = useTextEditingController(text: user?.bio);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    return LayoutWidget(
      title: "Edit Profile",
      child: SingleChildScrollView(
        child:  Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),

                AppFormField(
                  controller: emailField,
                  label: AppLocale.email,
                  isEnabled: false,
                ),

                const SizedBox(
                  height: 20,
                ),
                
                AppFormField(
                  controller: firstNameField,
                  label: "First name",
                  isRequired: true,
                ),

                const SizedBox(
                  height: 20,
                ),
                AppFormField(
                  controller: lastNameField,
                  label: "last name",
                  isRequired: true,
                ),

                const SizedBox(
                  height: 20,
                ),
                
                AppFormField(controller: bioField, label: "Bio", isMultiline: true,),
                
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
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.green, // This is what you need!
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Text("Save",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
