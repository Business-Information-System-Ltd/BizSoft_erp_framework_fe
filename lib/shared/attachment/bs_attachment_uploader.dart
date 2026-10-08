/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_attachment_uploader.dart
 Purpose      : attachment uploader placeholder.
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

class BsAttachmentUploader extends StatelessWidget {
  const BsAttachmentUploader({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.attach_file),
      label: const Text('Attach File'),
    );
  }
}
