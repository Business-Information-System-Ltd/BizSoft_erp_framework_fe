/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/add_address_dialog.dart
 *
 * Purpose:
 *   Dialog for adding or editing partner addresses.
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
import '../../data/models/partner_address_model.dart';
import 'partner_form_field_helpers.dart';

class AddAddressDialog extends StatefulWidget {
  const AddAddressDialog({super.key, this.initial});

  final PartnerAddressModel? initial;

  static Future<PartnerAddressModel?> show(
    BuildContext context, {
    PartnerAddressModel? initial,
  }) {
    return showDialog<PartnerAddressModel>(
      context: context,
      builder: (_) => AddAddressDialog(initial: initial),
    );
  }

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  late String _addressType = widget.initial?.addressType ?? 'Business';
  late String _country = widget.initial?.country ?? 'Myanmar';
  late String _stateRegion = widget.initial?.stateRegion ?? '';
  late String _township = widget.initial?.township ?? '';
  late String _city = widget.initial?.city ?? '';
  late String _streetBuilding = widget.initial?.streetBuilding ?? '';
  late String _postalCode = widget.initial?.postalCode ?? '';
  late String _fullAddress = widget.initial?.fullAddress ?? '';
  late bool _isPrimary = widget.initial?.isPrimary ?? true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initial == null ? 'Add Address' : 'Edit Address'),
      content: SizedBox(
        width: 720,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _field(
                'Address Type',
                _addressType,
                (value) => _addressType = value,
              ),
              _field('Country', _country, (value) => _country = value),
              _field(
                'State / Region',
                _stateRegion,
                (value) => _stateRegion = value,
              ),
              _field('Township', _township, (value) => _township = value),
              _field('City', _city, (value) => _city = value),
              _field(
                'Street / Building',
                _streetBuilding,
                (value) => _streetBuilding = value,
              ),
              _field(
                'Postal Code',
                _postalCode,
                (value) => _postalCode = value,
              ),
              SizedBox(
                width: 660,
                child: PartnerBoundTextField(
                  label: 'Full Address',
                  value: _fullAddress,
                  requiredField: true,
                  maxLines: 2,
                  onChanged: (value) => _fullAddress = value,
                ),
              ),
              SizedBox(
                width: 320,
                child: BsCheckboxField(
                  label: 'Primary Address',
                  value: _isPrimary,
                  onChanged: (value) => setState(() => _isPrimary = value),
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
          onPressed: _fullAddress.trim().isEmpty
              ? null
              : () => Navigator.of(context).pop(
                  PartnerAddressModel(
                    addressType: _addressType,
                    country: _country,
                    stateRegion: _stateRegion,
                    township: _township,
                    city: _city,
                    streetBuilding: _streetBuilding,
                    postalCode: _postalCode,
                    fullAddress: _fullAddress,
                    isPrimary: _isPrimary,
                  ),
                ),
          child: const Text('Save Address'),
        ),
      ],
    );
  }

  Widget _field(String label, String value, ValueChanged<String> onChanged) {
    return SizedBox(
      width: 320,
      child: PartnerBoundTextField(
        label: label,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
