/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : far_asset_list_page.dart
 Purpose      : FAR asset list placeholder page.
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

class FarAssetListPage extends StatelessWidget {
  const FarAssetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BsPage(title: 'FAR Assets', body: Center(child: Text('Asset list')));
  }
}
