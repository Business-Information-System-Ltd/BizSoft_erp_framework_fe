/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/employees/presentation/widgets/employee_profile_section.dart
 *
 * Purpose:
 *   Employee-specific profile placeholder that extends PartnerBasicInformation.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier, Customer, Employee, Doctor, Patient, Bank, and other profiles extend Partner.
 *   - Partner role and relationship are decided by caller program or backend onboarding service.
 *   - UI must not enforce final business policy; backend is the source of truth.
 *   - API calls must go through Repository and API Service.
 *   - First identity is displayed on the main form.
 *   - Additional identities are entered through dialog, side panel, or accordion.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
import 'package:flutter/material.dart';

import '../../../../shared/layout/bs_detail_area.dart';

class EmployeeProfileSection extends StatelessWidget {
  const EmployeeProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const BsDetailSection(
      title: 'Employee Profile Section',
      icon: Icons.badge_outlined,
      child: Text(
        'Employee payroll, schedule, and employment fields belong here.',
      ),
    );
  }
}
