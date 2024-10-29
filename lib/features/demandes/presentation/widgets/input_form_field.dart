import 'package:flutter/material.dart';

class InputFormField extends StatefulWidget {
  final String validationMessage;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const InputFormField(
      {super.key,
      required this.validationMessage,
      required this.controller,
      required this.hintText,
      this.maxLines = 1});

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: 5,
      validator: (value) => value!.isEmpty ? widget.validationMessage : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      minLines: widget.maxLines,
      decoration: InputDecoration(
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none),
          fillColor: Colors.white,
          filled: true),
    );
  }
}
