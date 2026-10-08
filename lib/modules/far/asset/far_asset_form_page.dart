/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : far_asset_form_page.dart
 Purpose      : FAR asset form placeholder page.
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

import '../../../shared/layout/bs_page.dart';
import 'widgets/far_asset_basic_section.dart';

class FarAssetFormPage extends StatelessWidget {
  const FarAssetFormPage({super.key, this.assetId});

  final String? assetId;

  @override
  Widget build(BuildContext context) {
    return BsPage(title: assetId == null ? 'New FAR Asset' : 'Edit FAR Asset', body: const FarAssetBasicSection());
  }
}
