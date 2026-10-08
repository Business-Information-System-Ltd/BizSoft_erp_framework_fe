/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_detail_provider.dart
 Purpose      : *   Fetches Partner detail records by id.
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

import '../../domain/models/partner_model.dart';
import 'partner_providers.dart';

final partnerDetailProvider = FutureProvider.family<PartnerModel, String>((ref, id) async {
  return ref.watch(partnerRepositoryProvider).getPartner(id);
});
