/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_page.dart
 Purpose      : Standard ERP page container with breadcrumb and page header support.
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

import '../../app/bs_app_theme.dart';
import '../../../../../shared/layout/bs_page_header.dart';
import '../../../../../shared/layout/bs_page.dart';

class BsPage extends StatelessWidget {
  const BsPage({
    super.key,
    required this.title,
    this.breadcrumb,
    this.header,
    this.toolbar,
    this.messagePanel,
    this.filterPanel,
    required this.body,
    this.footer,
    this.sidePanel,
  });

  final String title;
  final Widget? breadcrumb;
  final Widget? header;
  final Widget? toolbar;
  final Widget? messagePanel;
  final Widget? filterPanel;
  final Widget body;
  final Widget? footer;
  final Widget? sidePanel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BsAppTheme.pagePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (breadcrumb != null) ...[breadcrumb!, const SizedBox(height: 8)],
          header ?? BsPageHeader(title: title),
          if (toolbar != null) ...[const SizedBox(height: 10), toolbar!],
          if (messagePanel != null) ...[
            const SizedBox(height: 10),
            messagePanel!,
          ],
          if (filterPanel != null) ...[
            const SizedBox(height: 10),
            filterPanel!,
          ],
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: body),
                if (sidePanel != null) ...[
                  const SizedBox(width: 10),
                  SizedBox(width: 320, child: sidePanel!),
                ],
              ],
            ),
          ),
          if (footer != null) ...[const SizedBox(height: 10), footer!],
        ],
      ),
    );
  }
}
