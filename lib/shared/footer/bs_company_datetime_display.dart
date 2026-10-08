/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_company_datetime_display.dart
 Purpose      : Lower-right active date and live clock using selected company format.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/company/bs_company_provider.dart';

class BsCompanyDateTimeDisplay extends ConsumerStatefulWidget {
  const BsCompanyDateTimeDisplay({super.key});

  @override
  ConsumerState<BsCompanyDateTimeDisplay> createState() =>
      _BsCompanyDateTimeDisplayState();
}

class _BsCompanyDateTimeDisplayState
    extends ConsumerState<BsCompanyDateTimeDisplay> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final company = ref.watch(bsSelectedCompanyProvider);
    final pattern = '${company.dateFormat} ${company.timeFormat}';
    // TODO: Apply true timezone conversion using the timezone package when backend timezone rules are finalized.
    final displayText = DateFormat(pattern).format(_now);

    return Text(
      displayText,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.right,
      style: Theme.of(context).textTheme.labelMedium,
    );
  }
}
