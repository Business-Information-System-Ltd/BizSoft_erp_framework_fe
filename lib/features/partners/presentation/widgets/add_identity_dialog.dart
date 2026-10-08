/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/add_identity_dialog.dart
 *
 * Purpose:
 *   Dialog for adding or editing additional partner identities.
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
import '../../data/models/partner_identity_document_model.dart';
import 'first_identity_flat_form_section.dart';
import 'partner_form_field_helpers.dart';

class AddIdentityDialog extends StatefulWidget {
  const AddIdentityDialog({super.key, required this.partnerType, this.initial});

  final String partnerType;
  final PartnerIdentityDocumentModel? initial;

  static Future<PartnerIdentityDocumentModel?> show(
    BuildContext context, {
    required String partnerType,
    PartnerIdentityDocumentModel? initial,
  }) {
    return showDialog<PartnerIdentityDocumentModel>(
      context: context,
      builder: (_) =>
          AddIdentityDialog(partnerType: partnerType, initial: initial),
    );
  }

  @override
  State<AddIdentityDialog> createState() => _AddIdentityDialogState();
}

class _AddIdentityDialogState extends State<AddIdentityDialog> {
  late String _identityType = widget.initial?.identityType ?? '';
  late String _identityNo = widget.initial?.identityNo ?? '';
  late String _issuingCountry = widget.initial?.issuingCountry ?? 'Myanmar';
  late String _issuingAuthority = widget.initial?.issuingAuthority ?? '';
  late bool _isPrimary = widget.initial?.isPrimary ?? false;
  late String _attachmentId = widget.initial?.attachmentId ?? '';
  late String _remarks = widget.initial?.remarks ?? '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initial == null ? 'Add Identity' : 'Edit Identity'),
      content: SizedBox(
        width: 720,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 320,
                child: BsDropdownField<String>(
                  label: 'Identity Type',
                  value: _identityType.isEmpty ? null : _identityType,
                  requiredField: true,
                  onChanged: (value) =>
                      setState(() => _identityType = value ?? ''),
                  items: [
                    for (final type
                        in FirstIdentityFlatFormSection.identityTypesFor(
                          widget.partnerType,
                        ))
                      DropdownMenuItem(value: type, child: Text(type)),
                  ],
                ),
              ),
              SizedBox(
                width: 320,
                child: PartnerBoundTextField(
                  label: 'Identity No.',
                  value: _identityNo,
                  requiredField: true,
                  onChanged: (value) => _identityNo = value,
                ),
              ),
              SizedBox(
                width: 320,
                child: PartnerBoundTextField(
                  label: 'Issuing Country',
                  value: _issuingCountry,
                  onChanged: (value) => _issuingCountry = value,
                ),
              ),
              SizedBox(
                width: 320,
                child: PartnerBoundTextField(
                  label: 'Issuing Authority',
                  value: _issuingAuthority,
                  onChanged: (value) => _issuingAuthority = value,
                ),
              ),
              SizedBox(
                width: 320,
                child: PartnerBoundTextField(
                  label: 'Attachment ID',
                  value: _attachmentId,
                  onChanged: (value) => _attachmentId = value,
                ),
              ),
              SizedBox(
                width: 320,
                child: BsCheckboxField(
                  label: 'Primary Identity',
                  value: _isPrimary,
                  onChanged: (value) => setState(() => _isPrimary = value),
                ),
              ),
              SizedBox(
                width: 660,
                child: PartnerBoundTextField(
                  label: 'Remarks',
                  value: _remarks,
                  maxLines: 2,
                  onChanged: (value) => _remarks = value,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _identityType.trim().isEmpty || _identityNo.trim().isEmpty
              ? null
              : () => Navigator.of(context).pop(
                  PartnerIdentityDocumentModel(
                    identityType: _identityType,
                    identityNo: _identityNo,
                    issuingCountry: _issuingCountry,
                    issuingAuthority: _issuingAuthority,
                    isPrimary: _isPrimary,
                    attachmentId: _attachmentId,
                    remarks: _remarks,
                  ),
                ),
          child: const Text('Save Identity'),
        ),
      ],
    );
  }
}
