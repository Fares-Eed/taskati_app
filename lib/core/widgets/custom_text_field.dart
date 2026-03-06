
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.enabled = true,
    this.onTap,
    this.onChange,
    this.focusNode,
    this.maxLines,
    this.minLines,
  });
  final TextEditingController? controller;
  final String? hint;
  final Widget? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;
  final Function()? onTap;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      enabled: enabled,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        label: label,
        
      ),
      validator: validator,
      onTap: onTap,
      onChanged: onChange,
    );
  }
}
