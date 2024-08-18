import 'package:alive_diary/config/locale/app_locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class AppFieldWidget extends StatelessWidget {
  const AppFieldWidget({
    super.key,

    required this.controller,
    required this.label,
    this.isEnabled = true,
    this.isRequired = false,
    this.isMultiline = false,
    this.isPassword = false,

    this.suffixIcon,
    this.inputType = TextInputType.text,
    this.onTab,
  });

  final TextEditingController controller;
  final String label;
  final bool isEnabled;
  final bool isRequired;
  final bool isMultiline;
  final bool isPassword;
  final Widget? suffixIcon;
  final TextInputType inputType;
  final Function()? onTab;


  @override
  Widget build(BuildContext context) {
    return Container(
      child:TextFormField(
        enabled: isEnabled,
        keyboardType: inputType,
        controller: controller,
        validator: isRequired ? (val) => val!.isEmpty ? AppLocale.required.getString(context) : null : null,
        textInputAction: TextInputAction.next,
        maxLines: isMultiline ? 3 : 1,
        onTap: onTab,
        obscureText: isPassword,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: label,
          alignLabelWithHint: true,
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
    );
  }
}
