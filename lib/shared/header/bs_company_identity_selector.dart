/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_company_identity_selector.dart
 Purpose      : Header company logo/name selector filtered by allowed company permissions.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/company/bs_company.dart';
import '../../core/company/bs_company_provider.dart';
import 'bs_company_logo.dart';

class BsCompanyIdentitySelector extends ConsumerWidget {
  const BsCompanyIdentitySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCompany = ref.watch(bsSelectedCompanyProvider);
    final allowedCompanies = ref.watch(bsAllowedCompaniesProvider);

    return PopupMenuButton<String>(
      tooltip: 'Change company',
      offset: const Offset(0, 42),
      onSelected: (companyId) {
        // TODO: Confirm unsaved forms before switching the current working company.
        final company = allowedCompanies.firstWhere((item) => item.id == companyId);
        ref.read(bsSelectedCompanyProvider.notifier).state = company;
      },
      itemBuilder: (context) => [
        for (final company in allowedCompanies)
          PopupMenuItem<String>(
            value: company.id,
            child: _CompanyMenuItem(company: company, selected: company.id == selectedCompany.id),
          ),
      ],
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(3),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BsCompanyLogo(company: selectedCompany),
            const SizedBox(width: 10),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                selectedCompany.name,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }
}

class _CompanyMenuItem extends StatelessWidget {
  const _CompanyMenuItem({required this.company, required this.selected});

  final BsCompany company;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BsCompanyLogo(company: company, size: 26),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(company.name, overflow: TextOverflow.ellipsis),
              Text(company.code, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ),
        if (selected) const Icon(Icons.check, size: 18),
      ],
    );
  }
}