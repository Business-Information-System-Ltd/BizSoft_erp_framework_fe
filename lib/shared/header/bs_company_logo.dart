/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_company_logo.dart
 Purpose      : Compact company logo with fallback initials for the header selector.
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

import '../../core/company/bs_company.dart';

class BsCompanyLogo extends StatelessWidget {
  const BsCompanyLogo({
    super.key,
    required this.company,
    this.size = 30,
  });

  final BsCompany company;
  final double size;

  @override
  Widget build(BuildContext context) {
    final logoAssetPath = company.logoAssetPath;
    final logoUrl = company.logoUrl;
    final fallback = _FallbackLogo(company: company, size: size);

    if (logoAssetPath != null && logoAssetPath.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.asset(
          logoAssetPath,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => fallback,
        ),
      );
    }

    if (logoUrl != null && logoUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Image.network(
          logoUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => fallback,
        ),
      );
    }

    return fallback;
  }
}

class _FallbackLogo extends StatelessWidget {
  const _FallbackLogo({required this.company, required this.size});

  final BsCompany company;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        company.initials,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}