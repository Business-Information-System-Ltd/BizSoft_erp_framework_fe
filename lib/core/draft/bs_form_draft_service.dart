/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_form_draft_service.dart
 Purpose      : In-memory draft foundation for BizSoft form sessions.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bs_form_session_key.dart';

class BsFormDraftService {
  BsFormDraftService();

  final Map<BsFormSessionKey, Map<String, Object?>> _drafts = {};

  Future<void> saveDraft(
    BsFormSessionKey key,
    Map<String, Object?> values,
  ) async {
    _drafts[key] = Map<String, Object?>.from(values);
  }

  Future<Map<String, Object?>?> loadDraft(BsFormSessionKey key) async {
    final draft = _drafts[key];
    if (draft == null) {
      return null;
    }
    return Map<String, Object?>.from(draft);
  }

  Future<void> clearDraft(BsFormSessionKey key) async {
    _drafts.remove(key);
  }

  bool hasDraft(BsFormSessionKey key) {
    return _drafts.containsKey(key);
  }
}

final bsFormDraftServiceProvider = Provider<BsFormDraftService>((ref) {
  return BsFormDraftService();
});
