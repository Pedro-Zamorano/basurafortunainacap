import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatelessWidget {
  final String labelTitle;
  final bool obscureText;
  final IconData labelIcon;
  final TextEditingController controller;
  final TextInputType keyboardType;

  // optionals
  final String? hintText;
  final bool? status;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;
  final Color? iconColor;
  final Color? borderColor;
  final String? Function(String?)? validator;
  final TextInputFormatter? inputFormat;
  const TextInput({
    super.key,
    required this.labelTitle,
    required this.obscureText,
    required this.labelIcon,
    required this.controller,
    this.hintText,
    this.status,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.iconColor,
    this.borderColor,
    this.validator,
    this.inputFormat,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: status ?? true,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      inputFormatters: inputFormat != null ? [inputFormat!] : null,
      keyboardType: keyboardType,
      style: TextStyle(
        color: textColor ?? const Color(0xFF7DA0CA),
        fontSize: 20,
      ),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Icon(
            labelIcon,
            size: 40,
            color: iconColor ?? const Color(0xFFC1E8FF),
          ),
        ),
        label: Text(
          labelTitle,
          style: const TextStyle(fontSize: 20),
        ),
        labelStyle: TextStyle(
          color: labelColor ?? const Color(0xFFC1E8FF),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? const Color(0xFF7DA0CA),
          fontSize: 20,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? const Color(0xFF5483B3),
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
