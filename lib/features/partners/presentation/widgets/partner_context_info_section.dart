/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/partner_context_info_section.dart
 *
 * Purpose:
 *   Read-only caller context display for PartnerBasicInformation.
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

import '../../../../core/widgets/context_info_line.dart';
import '../../../../core/widgets/screen_context_panel.dart';
import '../state/partner_basic_information_form_state.dart';

List<ScreenContextItem> buildPartnerContextItems(
  PartnerBasicInformationCallerContext contextInfo,
) {
  return [
    ScreenContextItem(
      label: 'Caller Program',
      value: contextInfo.callerProgram,
    ),
    ScreenContextItem(label: 'Entry Mode', value: contextInfo.entryMode),
    ScreenContextItem(
      label: 'Current Legal Entity / Company',
      value: contextInfo.currentLegalEntityName ?? '-',
    ),
    ScreenContextItem(
      label: 'Current Branch / Organization Unit',
      value: contextInfo.currentOrganizationUnitName ?? '-',
    ),
    ScreenContextItem(
      label: 'Preselected Partner Type',
      value: contextInfo.preselectedPartnerType ?? '-',
    ),
    ScreenContextItem(
      label: 'Preselected Role',
      value: contextInfo.preselectedRole ?? '-',
    ),
    ScreenContextItem(
      label: 'Preselected Relationship',
      value: contextInfo.preselectedRelationship ?? '-',
    ),
    ScreenContextItem(
      label: 'Partner Type Editable',
      value: contextInfo.isPartnerTypeEditable ? 'Yes' : 'No',
    ),
  ];
}

class PartnerContextInfoSection extends StatelessWidget {
  const PartnerContextInfoSection({super.key, required this.contextInfo});

  final PartnerBasicInformationCallerContext contextInfo;

  @override
  Widget build(BuildContext context) {
    return PartnerContextInfoLine(contextInfo: contextInfo);
  }
}

class PartnerContextInfoLine extends StatelessWidget {
  const PartnerContextInfoLine({super.key, required this.contextInfo});

  final PartnerBasicInformationCallerContext contextInfo;

  @override
  Widget build(BuildContext context) {
    return ContextInfoLine(
      items: [
        ContextInfoLineItem(
          label: 'Company',
          value: contextInfo.currentLegalEntityName ?? '-',
          priority: 1,
        ),
        ContextInfoLineItem(
          label: 'Branch',
          value: contextInfo.currentOrganizationUnitName ?? '-',
          priority: 2,
        ),
        ContextInfoLineItem(
          label: 'Mode',
          value: contextInfo.entryMode,
          priority: 3,
        ),
        ContextInfoLineItem(
          label: 'Role',
          value: contextInfo.preselectedRole ?? '-',
          priority: 4,
        ),
        ContextInfoLineItem(
          label: 'Relationship',
          value: contextInfo.preselectedRelationship ?? '-',
          priority: 5,
        ),
        ContextInfoLineItem(
          label: 'Program',
          value: contextInfo.callerProgram,
          priority: 6,
        ),
      ],
    );
  }
}
