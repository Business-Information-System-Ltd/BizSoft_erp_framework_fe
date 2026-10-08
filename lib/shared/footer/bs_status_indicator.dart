/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_status_indicator.dart
 Purpose      : Footer system status indicator.
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

import '../../core/notification/bs_notification_provider.dart';

class BsStatusIndicator extends ConsumerWidget {
  const BsStatusIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(bsSystemStatusProvider);
    final color = switch (status) {
      BsSystemStatus.online => Colors.green,
      BsSystemStatus.offline => Colors.grey,
      BsSystemStatus.connecting => Colors.orange,
      BsSystemStatus.error => Theme.of(context).colorScheme.error,
    };
    final label = switch (status) {
      BsSystemStatus.online => 'Online',
      BsSystemStatus.offline => 'Offline',
      BsSystemStatus.connecting => 'Connecting',
      BsSystemStatus.error => 'Error',
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
