/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_type_dropdown.dart
 Purpose      : *   Provides a reusable Partner type dropdown.
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

import '../../../../core/widgets/app_dropdown.dart';
import '../../domain/enums/partner_enums.dart';

class PartnerTypeDropdown extends StatelessWidget {
  const PartnerTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final PartnerType value;
  final ValueChanged<PartnerType?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppDropdown<PartnerType>(
      label: 'Partner Type',
      value: value,
      enabled: enabled,
      items: [
        for (final type in PartnerType.values) AppDropdownItem(value: type, label: type.label),
      ],
      onChanged: onChanged,
    );
  }
}
