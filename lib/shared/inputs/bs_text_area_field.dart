/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_text_area_field.dart
 Purpose      : standard multi-line text area.
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

import 'bs_text_field.dart';

class BsTextAreaField extends StatelessWidget {
  const BsTextAreaField({
    super.key,
    required this.label,
    required this.controller,
    this.requiredField = false,
    this.maxLines = 4,
  });

  final String label;
  final TextEditingController controller;
  final bool requiredField;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return BsTextField(
      label: label,
      controller: controller,
      requiredField: requiredField,
      maxLines: maxLines,
      keyboardType: TextInputType.multiline,
    );
  }
}
