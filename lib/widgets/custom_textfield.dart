import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String text;
  final bool isObsecure;
  final String? Function(String?)? validator;

  final bool? isEnabled;
  final Function()? iconPressed;
  final String? Function(String?)? onChanged;

  const CustomTextField({
    Key? key,
    this.validator,
    this.controller,
    required this.text,
    required this.isObsecure,
    this.isEnabled = true,
    this.iconPressed,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      controller: controller,
      minLines: 1,
      maxLines: 1,
      obscureText: isObsecure,
      decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.only(bottom: 3, left: 5, top: 3),
          isDense: true,
          errorBorder: InputBorder.none,
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent)),
          errorStyle: const TextStyle(color: Colors.blueAccent),
          suffixIconConstraints:
              const BoxConstraints(maxWidth: 32, maxHeight: 32),
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: text,
          enabled: isEnabled!),
    );
  }
}
