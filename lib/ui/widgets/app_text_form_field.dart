import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hintText,
    required this.color,
    required this.controller, this.validator, this.obscureText, this.maxLines, this.readOnly, this.keyBoardType, this.suffixIcon,
  });

  final String hintText;
  final Color color;
  final TextEditingController controller;
  final Function(String?)? validator;

  final bool? obscureText;
  final int? maxLines;
  final bool? readOnly;
  final TextInputType? keyBoardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        controller: controller,
        obscureText: obscureText ?? false,
        obscuringCharacter: '*',
        keyboardType: keyBoardType,
        validator: (value) {
          if (validator != null) {
            return validator!(value);
          }
          return null;
        },

        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color(0xff454349),
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(34.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(34.0),
          ),
          filled: true,
          fillColor: color,
        ),
      ),
    );
  }
}