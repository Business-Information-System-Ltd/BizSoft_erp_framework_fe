/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_system_name_display.dart
 Purpose      : Center footer system/application name display.
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/company/bs_company_provider.dart';

class BsSystemNameDisplay extends ConsumerWidget {
  const BsSystemNameDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(bsSelectedCompanyProvider);
    return Text(
      company.systemName,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
