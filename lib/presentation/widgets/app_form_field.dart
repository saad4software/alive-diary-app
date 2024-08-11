import 'package:flutter/material.dart';

class AppFormField extends StatelessWidget {
  const AppFormField({
    required this.controller,
    required this.label,
    this.isEnabled = true,
    this.isRequired = false,
    this.isMultiline = false,

    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool isEnabled;
  final bool isRequired;
  final bool isMultiline;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:TextFormField(
        enabled: isEnabled,
        keyboardType: TextInputType.text,
        controller: controller,
        validator: isRequired ? (val) => val!.isEmpty ? 'Required' : null : null,
        maxLines: isMultiline ? 3 : null,
        decoration: InputDecoration(
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
