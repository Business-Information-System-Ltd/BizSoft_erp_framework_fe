/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_report_date_filter.dart
 Purpose      : reusable report date filter.
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

import '../../core/utils/bs_date_utils.dart';
import '../inputs/bs_date_field.dart';
import '../inputs/bs_dropdown_field.dart';
import '../inputs/bs_readonly_field.dart';
import 'bs_report_date_calculator.dart';
import 'bs_report_date_models.dart';

class BsReportDateFilter extends StatefulWidget {
  const BsReportDateFilter({
    super.key,
    required this.onChanged,
    this.minimumDate,
    this.maximumDate,
  });

  final ValueChanged<BsDateRangeFilterResult> onChanged;
  final DateTime? minimumDate;
  final DateTime? maximumDate;

  @override
  State<BsReportDateFilter> createState() => _BsReportDateFilterState();
}

class _BsReportDateFilterState extends State<BsReportDateFilter> {
  BsReportDatePreset _preset = BsReportDatePreset.today;
  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _applyPreset(_preset);
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final specific = _preset == BsReportDatePreset.specificDateRange;
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        SizedBox(
          width: 260,
          child: BsDropdownField<BsReportDatePreset>(
            label: 'Date Range',
            value: _preset,
            items: [
              for (final preset in BsReportDatePreset.values)
                DropdownMenuItem(value: preset, child: Text(preset.label)),
            ],
            onChanged: (value) {
              if (value != null) {
                _applyPreset(value);
              }
            },
          ),
        ),
        SizedBox(
          width: 180,
          child: specific
              ? BsDateField(
                  label: 'From Date',
                  controller: _fromController,
                  minimumDate: widget.minimumDate,
                  maximumDate: widget.maximumDate,
                  onChanged: (_) => _emit(),
                )
              : BsReadonlyField(label: 'From Date', value: _fromController.text),
        ),
        SizedBox(
          width: 180,
          child: specific
              ? BsDateField(
                  label: 'To Date',
                  controller: _toController,
                  minimumDate: widget.minimumDate,
                  maximumDate: widget.maximumDate,
                  onChanged: (_) => _emit(),
                )
              : BsReadonlyField(label: 'To Date', value: _toController.text),
        ),
      ],
    );
  }

  void _applyPreset(BsReportDatePreset preset) {
    final result = BsReportDateRangeCalculator.calculate(preset);
    setState(() {
      _preset = preset;
      _fromController.text = BsDateUtils.formatDate(result.fromDate);
      _toController.text = BsDateUtils.formatDate(result.toDate);
    });
    widget.onChanged(result);
  }

  void _emit() {
    final from = BsDateUtils.parseDate(_fromController.text);
    final to = BsDateUtils.parseDate(_toController.text);
    if (from != null && to != null) {
      widget.onChanged(BsDateRangeFilterResult(preset: _preset, fromDate: from, toDate: to));
    }
  }
}
