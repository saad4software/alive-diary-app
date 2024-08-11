import 'package:alive_diary/config/router/app_router.dart';
import 'package:alive_diary/domain/models/responses/ErrorResponse.dart';
import 'package:alive_diary/presentation/screens/confirm/confirm_bloc.dart';
import 'package:alive_diary/presentation/widgets/layout_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oktoast/oktoast.dart';


@RoutePage()
class ConfirmScreen extends HookWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<ConfirmBloc>(context);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final usernameField = useTextEditingController(text: "");
    final codeField = useTextEditingController(text: "");

    return LayoutWidget(
      title: "Confirm Account",
      child: SingleChildScrollView(
        child: BlocListener<ConfirmBloc, ConfirmState>(
          listener: (context, state) {
            if(state is ConfirmSuccessState) {
              showToast("Activated account successfully");
              appRouter.popUntil((route)=>route.settings.name == LoginRoute.name);
            } else if (state is ConfirmErrorState) {
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
                  const SizedBox(height: 20,),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameField,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    decoration: InputDecoration(

                      labelText: "Email",
                      labelStyle: const TextStyle(color: Colors.black38),
                      floatingLabelStyle: const TextStyle(
                          height: 4, color: Colors.black),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(width: 2),
                      ),

                      filled: true,
                    ),
                  ),
                  const SizedBox(height: 20,),

                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: codeField,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    decoration: InputDecoration(

                      labelText: "Code",
                      labelStyle: const TextStyle(color: Colors.black38),
                      floatingLabelStyle: const TextStyle(
                          height: 4, color: Colors.black),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(width: 2),
                      ),
                      filled: true,
                    ),
                  ),

                  const SizedBox(height: 20,),

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

                            bloc.add(ConfirmClickedEvent(
                              email: usernameField.text,
                              code: codeField.text,
                            ));

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.green, // This is what you need!
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text("Confirm",
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
