/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_attachment_list.dart
 Purpose      : attachment list display.
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

import 'bs_attachment_models.dart';

class BsAttachmentList extends StatelessWidget {
  const BsAttachmentList({
    super.key,
    required this.attachments,
  });

  final List<BsAttachmentModel> attachments;

  @override
  Widget build(BuildContext context) {
    if (attachments.isEmpty) {
      return const Text('No attachments.');
    }
    return Column(
      children: [
        for (final item in attachments)
          ListTile(
            dense: true,
            leading: const Icon(Icons.description_outlined),
            title: Text(item.fileName),
          ),
      ],
    );
  }
}
