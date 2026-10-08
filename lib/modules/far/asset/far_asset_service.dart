/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : far_asset_service.dart
 Purpose      : FAR asset service placeholder.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'far_asset_model.dart';

class FarAssetService {
  Future<List<FarAssetModel>> getAssets() async {
    return const [FarAssetModel(id: 1, assetCode: 'AST-001', assetName: 'Sample Asset')];
  }
}
