import 'package:flutter/material.dart';

import 'package:bizsoft_frontend_framework/features/partners/presentation/widgets/partner_form_field_helpers.dart';
import 'package:bizsoft_frontend_framework/shared/inputs/bs_readonly_field.dart';

class BranchAddressDraft {
  const BranchAddressDraft({
    required this.addressLine1,
    this.addressLine2,
    required this.township,
    required this.city,
    this.postalCode,
  });

  final String addressLine1;
  final String? addressLine2;
  final String township;
  final String city;
  final String? postalCode;
}

class BranchAddAddressDialog extends StatefulWidget {
  const BranchAddAddressDialog({
    super.key,
    required this.regionName,
    required this.zoneName,
    this.initialAddressLine1 = '',
    this.initialAddressLine2 = '',
    this.initialTownship = '',
    this.initialCity = '',
    this.initialPostalCode = '',
  });

  final String? regionName;
  final String? zoneName;
  final String initialAddressLine1;
  final String initialAddressLine2;
  final String initialTownship;
  final String initialCity;
  final String initialPostalCode;

  static Future<BranchAddressDraft?> show(
    BuildContext context, {
    required String? regionName,
    required String? zoneName,
    String initialAddressLine1 = '',
    String initialAddressLine2 = '',
    String initialTownship = '',
    String initialCity = '',
    String initialPostalCode = '',
  }) {
    return showDialog<BranchAddressDraft>(
      context: context,
      builder: (_) => BranchAddAddressDialog(
        regionName: regionName,
        zoneName: zoneName,
        initialAddressLine1: initialAddressLine1,
        initialAddressLine2: initialAddressLine2,
        initialTownship: initialTownship,
        initialCity: initialCity,
        initialPostalCode: initialPostalCode,
      ),
    );
  }

  @override
  State<BranchAddAddressDialog> createState() =>
      _BranchAddAddressDialogState();
}

class _BranchAddAddressDialogState extends State<BranchAddAddressDialog> {
  late String _addressLine1 = widget.initialAddressLine1;
  late String _addressLine2 = widget.initialAddressLine2;
  late String _township = widget.initialTownship;
  late String _city = widget.initialCity;
  late String _postalCode = widget.initialPostalCode;

  @override
  Widget build(BuildContext context) {
    final canSave =
        _addressLine1.trim().isNotEmpty &&
        _township.trim().isNotEmpty &&
        _city.trim().isNotEmpty &&
        widget.regionName?.trim().isNotEmpty == true &&
        widget.zoneName?.trim().isNotEmpty == true;

    return AlertDialog(
      title: Text(
        widget.initialAddressLine1.trim().isEmpty
            ? 'Add Address'
            : 'Edit Address',
      ),
      content: SizedBox(
        width: 720,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _field(
                'Address Line 1',
                _addressLine1,
                (value) => setState(() => _addressLine1 = value),
                requiredField: true,
              ),
              _field(
                'Address Line 2',
                _addressLine2,
                (value) => setState(() => _addressLine2 = value),
              ),
              _field(
                'Township',
                _township,
                (value) => setState(() => _township = value),
                requiredField: true,
              ),
              _field(
                'City',
                _city,
                (value) => setState(() => _city = value),
                requiredField: true,
              ),
              SizedBox(
                width: 320,
                child: BsReadonlyField(
                  label: 'Region',
                  value: widget.regionName,
                ),
              ),
              SizedBox(
                width: 320,
                child: BsReadonlyField(
                  label: 'Zone',
                  value: widget.zoneName,
                ),
              ),
              _field(
                'Postal Code',
                _postalCode,
                (value) => setState(() => _postalCode = value),
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
          onPressed: canSave
              ? () => Navigator.of(context).pop(
                    BranchAddressDraft(
                      addressLine1: _addressLine1.trim(),
                      addressLine2: _addressLine2.trim().isEmpty
                          ? null
                          : _addressLine2.trim(),
                      township: _township.trim(),
                      city: _city.trim(),
                      postalCode: _postalCode.trim().isEmpty
                          ? null
                          : _postalCode.trim(),
                    ),
                  )
              : null,
          child: const Text('Save Address'),
        ),
      ],
    );
  }

  Widget _field(
    String label,
    String value,
    ValueChanged<String> onChanged, {
    bool requiredField = false,
  }) {
    return SizedBox(
      width: 320,
      child: PartnerBoundTextField(
        label: label,
        value: value,
        requiredField: requiredField,
        onChanged: onChanged,
      ),
    );
  }
}
