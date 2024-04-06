import 'package:flutter/material.dart';

class CustomTextFormFiled extends StatelessWidget {
  final String? hintText;
  final Function(String)? onChanged;
  final bool? securedPassword;

  const CustomTextFormFiled({
    super.key,
    this.hintText,
    this.onChanged,
    this.securedPassword = false,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: securedPassword!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
