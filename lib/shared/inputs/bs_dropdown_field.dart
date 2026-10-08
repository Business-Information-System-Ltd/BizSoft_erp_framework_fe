/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_dropdown_field.dart
 Purpose      : reusable dropdown for small lists.
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

class BsDropdownField<T> extends StatelessWidget {
  const BsDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredField = false,
    this.helperText,
    this.errorText,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final bool requiredField;
  final String? helperText;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      validator: requiredField
          ? (value) => value == null ? '$label is required.' : null
          : null,
      decoration: InputDecoration(
        isDense: true,
        labelText: requiredField ? '$label *' : label,
        helperText: helperText,
        errorText: errorText,
      ),
    );
  }
}
