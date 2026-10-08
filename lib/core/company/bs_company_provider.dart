/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_company_provider.dart
 Purpose      : Riverpod providers for company list, allowed companies, and current working company.
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
import 'package:flutter_riverpod/legacy.dart';

import '../auth/bs_permission_provider.dart';
import 'bs_company.dart';
import 'bs_company_service.dart';

final bsCompanyServiceProvider = Provider<BsCompanyService>((ref) {
  return const BsCompanyService();
});

final bsCompanyListProvider = Provider<List<BsCompany>>((ref) {
  return ref.watch(bsCompanyServiceProvider).getCompanies();
});

final bsAllowedCompaniesProvider = Provider<List<BsCompany>>((ref) {
  final user = ref.watch(bsCurrentUserProvider);
  final companies = ref.watch(bsCompanyListProvider);
  final allowedIds = user.allowedCompanyIds.toSet();
  final allowed = companies.where((company) => allowedIds.contains(company.id)).toList();
  return allowed.isEmpty ? companies : allowed;
});

final bsSelectedCompanyProvider = StateProvider<BsCompany>((ref) {
  return ref.watch(bsAllowedCompaniesProvider).first;
});