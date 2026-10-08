/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_bound_fields.dart
 Purpose      : Bound input field helpers for reusable state-driven form sections.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';

import '../../core/utils/bs_date_utils.dart';
import 'bs_date_field.dart';
import 'bs_text_field.dart';

class BsBoundTextField extends StatefulWidget {
  const BsBoundTextField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.requiredField = false,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.helperText,
    this.errorText,
    this.keyboardType = TextInputType.text,
  });

  final String label;
  final String value;
  final ValueChanged<String> onChanged;
  final bool requiredField;
  final bool enabled;
  final int maxLines;
  final int? maxLength;
  final String? helperText;
  final String? errorText;
  final TextInputType keyboardType;

  @override
  State<BsBoundTextField> createState() => _BsBoundTextFieldState();
}

class _BsBoundTextFieldState extends State<BsBoundTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant BsBoundTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BsTextField(
      label: widget.label,
      controller: _controller,
      requiredField: widget.requiredField,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      helperText: widget.helperText,
      errorText: widget.errorText,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
    );
  }
}

class BsBoundDateField extends StatefulWidget {
  const BsBoundDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  @override
  State<BsBoundDateField> createState() => _BsBoundDateFieldState();
}

class _BsBoundDateFieldState extends State<BsBoundDateField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _format(widget.value));
  }

  @override
  void didUpdateWidget(covariant BsBoundDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = _format(widget.value);
    if (_controller.text != next) {
      _controller.text = next;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BsDateField(
      label: widget.label,
      controller: _controller,
      onChanged: widget.onChanged,
    );
  }

  String _format(DateTime? value) {
    return value == null ? '' : BsDateUtils.formatDate(value);
  }
}
