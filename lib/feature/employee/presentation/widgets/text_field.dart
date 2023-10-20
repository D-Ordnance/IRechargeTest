import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final void Function(String) onChange;
  const CustomTextField(
      {super.key,
      required this.hint,
      required this.controller,
      this.obscureText = false,
      required this.onChange});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFFCE80)),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
      onChanged: (value) => onChange(value),
    );
  }
}
