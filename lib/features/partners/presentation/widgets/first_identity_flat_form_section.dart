/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/first_identity_flat_form_section.dart
 *
 * Purpose:
 *   Flat first identity form displayed directly on PartnerBasicInformation.
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

import '../../../../shared/inputs/bs_checkbox_field.dart';
import '../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../core/widgets/responsive_form_grid.dart';
import '../../../../shared/layout/bs_form_row.dart';
import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';
import 'partner_form_field_helpers.dart';

class FirstIdentityFlatFormSection extends StatelessWidget {
  const FirstIdentityFlatFormSection({
    super.key,
    required this.state,
    required this.notifier,
    this.readOnly = false,
  });

  final PartnerBasicInformationFormState state;
  final PartnerBasicInformationFormNotifier notifier;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final identity = state.firstIdentity;
    return BsFormRow(
      children: [
        BsDropdownField<String>(
          label: 'Identity Type',
          value: identity.identityType.isEmpty ? null : identity.identityType,
          requiredField: true,
          errorText: state.validationErrors['firstIdentityType'],
          onChanged: readOnly
              ? null
              : (value) => notifier.updateFirstIdentity(
                  identity.copyWith(identityType: value),
                ),
          items: [
            for (final type in identityTypesFor(state.partnerType))
              DropdownMenuItem(value: type, child: Text(type)),
          ],
        ),
        PartnerBoundTextField(
          label: 'Identity No.',
          value: identity.identityNo,
          requiredField: true,
          errorText: state.validationErrors['firstIdentityNo'],
          enabled: !readOnly,
          onChanged: (value) => notifier.updateFirstIdentity(
            identity.copyWith(identityNo: value),
          ),
        ),
        PartnerBoundTextField(
          label: 'Issuing Country',
          value: identity.issuingCountry,
          enabled: !readOnly,
          onChanged: (value) => notifier.updateFirstIdentity(
            identity.copyWith(issuingCountry: value),
          ),
        ),
        PartnerBoundTextField(
          label: 'Issuing Authority',
          value: identity.issuingAuthority,
          enabled: !readOnly,
          onChanged: (value) => notifier.updateFirstIdentity(
            identity.copyWith(issuingAuthority: value),
          ),
        ),
        PartnerBoundDateField(
          label: 'Issue Date',
          value: identity.issueDate,
          onChanged: (value) =>
              notifier.updateFirstIdentity(identity.copyWith(issueDate: value)),
        ),
        PartnerBoundDateField(
          label: 'Expiry Date',
          value: identity.expiryDate,
          onChanged: (value) => notifier.updateFirstIdentity(
            identity.copyWith(expiryDate: value),
          ),
        ),
        BsCheckboxField(
          label: 'Primary Identity',
          value: identity.isPrimary,
          onChanged: readOnly
              ? (_) {}
              : (value) => notifier.updateFirstIdentity(
                  identity.copyWith(isPrimary: value),
                ),
        ),
        PartnerBoundTextField(
          label: 'Attachment ID',
          value: identity.attachmentId,
          enabled: !readOnly,
          onChanged: (value) => notifier.updateFirstIdentity(
            identity.copyWith(attachmentId: value),
          ),
        ),
        ResponsiveFormGridFullWidth(
          child: PartnerBoundTextField(
            label: 'Identity Remarks',
            value: identity.remarks,
            enabled: !readOnly,
            maxLines: 2,
            onChanged: (value) =>
                notifier.updateFirstIdentity(identity.copyWith(remarks: value)),
          ),
        ),
      ],
    );
  }

  static List<String> identityTypesFor(String partnerType) {
    return switch (partnerType) {
      'NATURAL_PERSON' => const [
        'NRC',
        'Passport',
        'Driver License',
        'Social Security No.',
        'Tax ID',
        'Professional License',
        'Other',
      ],
      'GOVERNMENT_BODY' => const [
        'Government Registration Code',
        'Department Code',
        'Official Gazette Reference',
        'Tax Exemption Reference',
        'Other',
      ],
      'OTHER' => const ['Reference ID', 'License', 'Other'],
      _ => const [
        'Company Registration No.',
        'Business License',
        'Tax Identification No.',
        'Commercial Tax Registration',
        'Import Export License',
        'Financial Institution License',
        'NGO Registration',
        'Professional Firm License',
        'Other',
      ],
    };
  }
}
