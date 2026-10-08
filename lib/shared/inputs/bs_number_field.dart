/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_number_field.dart
 Purpose      : standard numeric input field.
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
import 'package:flutter/services.dart';

class BsNumberField extends StatelessWidget {
  const BsNumberField({
    super.key,
    required this.label,
    required this.controller,
    this.requiredField = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final bool requiredField;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      validator: requiredField
          ? (value) =>
                value == null || value.isEmpty ? '$label is required.' : null
          : null,
      decoration: InputDecoration(
        isDense: true,
        labelText: requiredField ? '$label *' : label,
      ),
    );
  }
}
