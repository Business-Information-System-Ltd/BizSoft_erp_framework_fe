/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_company_service.dart
 Purpose      : Mock company service for the first shell implementation.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_company.dart';

class BsCompanyService {
  const BsCompanyService();

  List<BsCompany> getCompanies() {
    return const <BsCompany>[
      BsCompany(
        id: 'BIZSOFT',
        code: 'BIZSOFT',
        name: 'BizSoft Systems',
        logoAssetPath: 'assets/images/company/bizsoft_logo.png',
        timezone: 'Asia/Yangon',
        dateFormat: 'yyyy-MM-dd',
        timeFormat: 'HH:mm:ss',
        systemName: 'BizSoft ERP System',
      ),
      BsCompany(
        id: 'DEMO',
        code: 'DEMO',
        name: 'Demo Company Ltd.',
        logoAssetPath: 'assets/images/company/demo_logo.png',
        timezone: 'Asia/Yangon',
        dateFormat: 'dd/MM/yyyy',
        timeFormat: 'HH:mm:ss',
        systemName: 'BizSoft ERP System',
      ),
      BsCompany(
        id: 'SGDEMO',
        code: 'SGDEMO',
        name: 'Singapore Demo Company',
        logoAssetPath: 'assets/images/company/sg_demo_logo.png',
        timezone: 'Asia/Singapore',
        dateFormat: 'dd-MMM-yyyy',
        timeFormat: 'HH:mm:ss',
        systemName: 'BizSoft ERP System',
      ),
    ];
  }
}