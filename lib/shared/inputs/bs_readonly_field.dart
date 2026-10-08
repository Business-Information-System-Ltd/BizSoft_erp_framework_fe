/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_readonly_field.dart
 Purpose      : read-only label/value display field.
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

class BsReadonlyField extends StatelessWidget {
  const BsReadonlyField({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(labelText: label),
      child: Text(value == null || value!.isEmpty ? '-' : value!),
    );
  }
}
