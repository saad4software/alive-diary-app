import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/responses/ErrorResponse.dart';
import 'package:alive_diary/presentation/screens/register/register_bloc.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
      title: "Register",
      child: SingleChildScrollView(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if(state is RegisterSuccessState) {
              showToast("Registered successfully");
              appRouter.push(const ConfirmRoute());
            } else if (state is RegisterErrorState) {
              final msg = state.error?.response?.data == null ?
                state.error?.message :
                ErrorResponse.fromJson(state.error?.response?.data).message?.trim();

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
                    controller: emailField,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    decoration: InputDecoration(
                      labelText: "Email",
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
                    keyboardType: TextInputType.text,
                    controller: passwordField,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
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
                    keyboardType: TextInputType.text,
                    controller: confirmField,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
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
                    keyboardType: TextInputType.text,
                    controller: firstNameField,
                    decoration: InputDecoration(
                      labelText: "First Name",
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
                    keyboardType: TextInputType.text,
                    controller: lastNameField,
                    decoration: InputDecoration(
                      labelText: "Last Name",
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
                    keyboardType: TextInputType.text,
                    controller: lastNameField,
                    maxLines: 3,
                    decoration: InputDecoration(
                      filled: true,
                      labelText: "Bio",
                      labelStyle: const TextStyle(color: Colors.black38),
                      floatingLabelStyle:
                          const TextStyle(height: 4, color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(width: 2),
                      ),
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
                      ElevatedButton(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text("Register",
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
      ),
    );
  }
}
