/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_form_section.dart
 Purpose      : Branch basic information form section.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import 'package:flutter/material.dart';

import '../../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../../shared/inputs/bs_text_field.dart';
import '../../../../../shared/layout/bs_form_row.dart';

class BranchFormSection
    extends StatelessWidget {
  const BranchFormSection({
    super.key,
    required this.legalEntityName,
    required this.branchCodeController,
    required this.branchNameController,
    required this.branchType,
    required this.branchTypeOptions,
    required this.onBranchCodeChanged,
    required this.onBranchNameChanged,
    required this.onBranchTypeChanged,
    required this.enabled,
  });

  final String legalEntityName;

  final TextEditingController
      branchCodeController;

  final TextEditingController
      branchNameController;

  final String? branchType;

  final List<String>
      branchTypeOptions;

  final ValueChanged<String?>
      onBranchTypeChanged;

  final ValueChanged<String>
      onBranchCodeChanged;

  final ValueChanged<String>
      onBranchNameChanged;

  final bool enabled;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.stretch,
      children: [
       
        BsFormRow(
          fieldWidth:
              260,
          maxColumns:
              3,
          children: [
         
            BsTextField(
              label:
                  'Legal Entity',
              controller:
                  TextEditingController(
                text:
                    legalEntityName,
              ),
              requiredField:
                  true,
              readOnly:
                  true,
              enabled:
                  enabled,
              suffixIcon:
                  const Icon(
                Icons.lock_outline,
                size: 18,
              ),
            ),

            BsTextField(
              label:
                  'Branch Code',
              controller:
                  branchCodeController,
              requiredField:
                  true,
              enabled:
                  enabled,
              hintText:
                  'Enter branch code',
              helperText:
                  'Leave blank for auto code',
              onChanged:
                  onBranchCodeChanged,
            ),

            BsTextField(
              label:
                  'Branch Name',
              controller:
                  branchNameController,
              requiredField:
                  true,
              enabled:
                  enabled,
              hintText:
                  'Enter branch name',
              onChanged:
                  onBranchNameChanged,
            ),
          ],
        ),

        const SizedBox(
          height: 12,
        ),

        BsFormRow(
          fieldWidth:
              260,
          maxColumns:
              3,
          children: [
            BsDropdownField<String>(
              label:
                  'Branch Type',
              value:
                  branchType,
              requiredField:
                  true,
              items:
                  branchTypeOptions
                      .map(
                        (
                          type,
                        ) {
                          return DropdownMenuItem<
                              String>(
                            value:
                                type,
                            child:
                                Text(type),
                          );
                        },
                      )
                      .toList(),
              onChanged:
                  enabled
                      ? onBranchTypeChanged
                      : null,
            ),
          ],
        ),
      ],
    );
  }
}