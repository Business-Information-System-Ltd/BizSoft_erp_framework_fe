/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/add_contact_person_dialog.dart
 *
 * Purpose:
 *   Dialog for adding or editing partner contact persons.
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
import '../../data/models/partner_contact_person_model.dart';
import 'partner_form_field_helpers.dart';

class AddContactPersonDialog extends StatefulWidget {
  const AddContactPersonDialog({super.key, this.initial});

  final PartnerContactPersonModel? initial;

  static Future<PartnerContactPersonModel?> show(
    BuildContext context, {
    PartnerContactPersonModel? initial,
  }) {
    return showDialog<PartnerContactPersonModel>(
      context: context,
      builder: (_) => AddContactPersonDialog(initial: initial),
    );
  }

  @override
  State<AddContactPersonDialog> createState() => _AddContactPersonDialogState();
}

class _AddContactPersonDialogState extends State<AddContactPersonDialog> {
  late String _name = widget.initial?.contactPersonName ?? '';
  late String _position = widget.initial?.position ?? '';
  late String _phoneNo = widget.initial?.phoneNo ?? '';
  late String _email = widget.initial?.email ?? '';
  late String _relationship = widget.initial?.relationshipToOrganization ?? '';
  late bool _isPrimary = widget.initial?.isPrimary ?? true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.initial == null ? 'Add Contact Person' : 'Edit Contact Person',
      ),
      content: SizedBox(
        width: 720,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _field(
              'Contact Person Name',
              _name,
              (value) => _name = value,
              required: true,
            ),
            _field(
              'Position / Designation',
              _position,
              (value) => _position = value,
            ),
            _field(
              'Phone No.',
              _phoneNo,
              (value) => _phoneNo = value,
              required: true,
            ),
            _field('Email', _email, (value) => _email = value),
            _field(
              'Relationship to Organization',
              _relationship,
              (value) => _relationship = value,
            ),
            SizedBox(
              width: 320,
              child: BsCheckboxField(
                label: 'Primary Contact',
                value: _isPrimary,
                onChanged: (value) => setState(() => _isPrimary = value),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _name.trim().isEmpty || _phoneNo.trim().isEmpty
              ? null
              : () => Navigator.of(context).pop(
                  PartnerContactPersonModel(
                    contactPersonName: _name,
                    position: _position,
                    phoneNo: _phoneNo,
                    email: _email,
                    relationshipToOrganization: _relationship,
                    isPrimary: _isPrimary,
                  ),
                ),
          child: const Text('Save Contact'),
        ),
      ],
    );
  }

  Widget _field(
    String label,
    String value,
    ValueChanged<String> onChanged, {
    bool required = false,
  }) {
    return SizedBox(
      width: 320,
      child: PartnerBoundTextField(
        label: label,
        value: value,
        requiredField: required,
        onChanged: onChanged,
      ),
    );
  }
}
