/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : far_asset_model.dart
 Purpose      : FAR asset placeholder model.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class FarAssetModel {
  const FarAssetModel({required this.id, required this.assetCode, required this.assetName});

  final int id;
  final String assetCode;
  final String assetName;
}
