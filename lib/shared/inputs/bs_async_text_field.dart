/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_async_text_field.dart
 Purpose      : text field with debounced backend validation.
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

import '../../core/validators/bs_async_validation_result.dart';
import 'bs_text_field.dart';

class BsAsyncTextField extends StatefulWidget {
  const BsAsyncTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.asyncValidator,
    this.requiredField = false,
    this.maxLength,
    this.minimumLengthForValidation = 2,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.onValidationChanged,
  });

  final String label;
  final TextEditingController controller;
  final bool requiredField;
  final int? maxLength;
  final int minimumLengthForValidation;
  final Duration debounceDuration;
  final Future<BsAsyncValidationResult> Function(String value) asyncValidator;
  final ValueChanged<BsAsyncValidationResult>? onValidationChanged;

  @override
  State<BsAsyncTextField> createState() => _BsAsyncTextFieldState();
}

class _BsAsyncTextFieldState extends State<BsAsyncTextField> {
  Timer? _timer;
  bool _checking = false;
  BsAsyncValidationResult? _result;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scheduleValidation);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scheduleValidation);
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BsTextField(
      label: widget.label,
      controller: widget.controller,
      requiredField: widget.requiredField,
      maxLength: widget.maxLength,
      helperText: _checking ? 'Checking...' : _result?.message,
      errorText: _result == null || _result!.isValid ? null : _result!.message,
      suffixIcon: _checking
          ? const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)),
            )
          : _result == null
              ? null
              : Icon(_result!.isValid ? Icons.check_circle : Icons.error_outline),
    );
  }

  void _scheduleValidation() {
    _timer?.cancel();
    final value = widget.controller.text.trim();
    if (value.length < widget.minimumLengthForValidation) {
      setState(() => _result = null);
      return;
    }
    _timer = Timer(widget.debounceDuration, () async {
      setState(() => _checking = true);
      final result = await widget.asyncValidator(value);
      if (!mounted) {
        return;
      }
      setState(() {
        _checking = false;
        _result = result;
      });
      widget.onValidationChanged?.call(result);
    });
  }
}
