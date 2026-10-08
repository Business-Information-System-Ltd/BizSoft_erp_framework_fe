/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_text_field.dart
 Purpose      : standard text input field.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';

class BsTextField extends StatelessWidget {
  const BsTextField({
    super.key,
    required this.label,
    required this.controller,
    this.requiredField = false,
    this.readOnly = false,
    this.enabled = true,
    this.hintText,
    this.helperText,
    this.errorText,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onTap,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final TextEditingController controller;
  final bool requiredField;
  final bool readOnly;
  final bool enabled;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final int? maxLength;
  final int maxLines;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator ?? (requiredField ? _requiredValidator : null),
      decoration: InputDecoration(
        isDense: true,
        labelText: requiredField ? '$label *' : label,
        hintText: hintText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  String? _requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required.';
    }
    return null;
  }
}
