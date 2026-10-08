/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/employees/presentation/screens/employee_form_screen.dart
 *
 * Purpose:
 *   Example employee onboarding screen embedding PartnerBasicInformation.
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/layout/bs_page.dart';
import '../../../partners/presentation/providers/partner_basic_information_form_provider.dart';
import '../../../partners/presentation/widgets/partner_basic_information.dart';
import '../widgets/employee_profile_section.dart';

class EmployeeFormScreen extends ConsumerWidget {
  const EmployeeFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnerBasicInformationFormProvider);
    final notifier = ref.read(partnerBasicInformationFormProvider.notifier);
    return BsPage(
      title: 'Employee Entry',
      body: ListView(
        children: [
          PartnerBasicInformation(
            state: state,
            notifier: notifier,
            isEmbeddedMode: true,
            showContextInfo: true,
          ),
          const SizedBox(height: 12),
          const EmployeeProfileSection(),
        ],
      ),
    );
  }
}
