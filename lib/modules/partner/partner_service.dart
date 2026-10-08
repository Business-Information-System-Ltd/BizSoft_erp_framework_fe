/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_service.dart
 Purpose      : Partner service placeholder.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'partner_model.dart';

class PartnerService {
  Future<List<PartnerModel>> getPartners() async {
    return const [PartnerModel(id: 1, code: 'P001', name: 'Sample Partner')];
  }
}
