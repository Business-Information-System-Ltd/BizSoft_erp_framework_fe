/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_identity_section.dart
 Purpose      : Partner identity section placeholder.
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

import '../../../shared/layout/bs_section_card.dart';

class PartnerIdentitySection extends StatelessWidget {
  const PartnerIdentitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const BsSectionCard(title: 'Partner Identity', child: Text('Partner identity fields'));
  }
}
