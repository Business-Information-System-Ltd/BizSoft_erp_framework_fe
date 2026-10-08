/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_footer_message_provider.dart
 Purpose      : Riverpod notifier for temporary shell footer messages.
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

import 'package:flutter_riverpod/legacy.dart';

import 'bs_footer_message.dart';

class BsFooterMessageNotifier extends StateNotifier<BsFooterMessage?> {
  BsFooterMessageNotifier() : super(null);

  Timer? _timer;

  void showSuccess(String message) => _show(message, BsFooterMessageType.success);

  void showInfo(String message) => _show(message, BsFooterMessageType.info);

  void showWarning(String message) => _show(message, BsFooterMessageType.warning);

  void showError(String message) => _show(message, BsFooterMessageType.error);

  void showValidation(String message) => _show(message, BsFooterMessageType.validation);

  void clear() {
    _timer?.cancel();
    _timer = null;
    state = null;
  }

  void _show(String message, BsFooterMessageType type) {
    final next = BsFooterMessage(message: message, type: type);
    state = next;
    _timer?.cancel();
    _timer = Timer(next.duration, () {
      if (state?.id == next.id) {
        state = null;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final bsFooterMessageProvider = StateNotifierProvider<BsFooterMessageNotifier, BsFooterMessage?>((ref) {
  return BsFooterMessageNotifier();
});