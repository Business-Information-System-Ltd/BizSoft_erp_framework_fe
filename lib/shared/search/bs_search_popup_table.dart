/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_search_popup_table.dart
 Purpose      : popup table for inserting search rules.
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

import 'bs_search_models.dart';

class BsSearchPopupTable extends StatelessWidget {
  const BsSearchPopupTable({
    super.key,
    required this.items,
    required this.onSelected,
  });

  final List<BsSearchPopupItem> items;
  final ValueChanged<BsSearchPopupItem> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 260, minWidth: 320),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              dense: true,
              title: Text(item.label),
              subtitle: item.description == null ? null : Text(item.description!),
              onTap: () => onSelected(item),
            );
          },
        ),
      ),
    );
  }
}
