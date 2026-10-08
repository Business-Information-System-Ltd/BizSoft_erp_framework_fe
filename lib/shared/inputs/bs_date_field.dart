/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_date_field.dart
 Purpose      : standard date picker field.
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

import '../../core/utils/bs_date_utils.dart';

class BsDateField extends StatelessWidget {
  const BsDateField({
    super.key,
    required this.label,
    required this.controller,
    this.minimumDate,
    this.maximumDate,
    this.requiredField = false,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool requiredField;
  final ValueChanged<DateTime>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      validator: requiredField
          ? (value) =>
                value == null || value.isEmpty ? '$label is required.' : null
          : null,
      decoration: InputDecoration(
        isDense: true,
        labelText: requiredField ? '$label *' : label,
        suffixIcon: const Icon(Icons.calendar_month),
      ),
      onTap: () => _pickDate(context),
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final current = BsDateUtils.parseDate(controller.text);
    final today = DateTime.now();
    final firstDate = minimumDate ?? DateTime(today.year - 20);
    final lastDate = maximumDate ?? DateTime(today.year + 20);
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? today,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      controller.text = BsDateUtils.formatDate(picked);
      onChanged?.call(picked);
    }
  }
}
