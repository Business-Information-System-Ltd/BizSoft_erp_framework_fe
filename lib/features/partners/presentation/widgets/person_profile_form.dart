/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : person_profile_form.dart
 Purpose      : *   Renders natural person profile fields for a Partner.
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

import '../../../../core/widgets/app_date_field.dart';
import '../../../../core/widgets/app_section_card.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../domain/models/person_profile_model.dart';

class PersonProfileForm extends StatelessWidget {
  const PersonProfileForm({
    super.key,
    required this.profile,
    required this.onChanged,
    this.enabled = true,
  });

  final PersonProfileModel profile;
  final ValueChanged<PersonProfileModel> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Person Profile',
      child: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          SizedBox(width: 320, child: AppTextField(label: 'First Name', value: profile.firstName, enabled: enabled, onChanged: (v) => onChanged(profile.copyWith(firstName: v)))),
          SizedBox(width: 320, child: AppTextField(label: 'Middle Name', value: profile.middleName, enabled: enabled, onChanged: (v) => onChanged(profile.copyWith(middleName: v)))),
          SizedBox(width: 320, child: AppTextField(label: 'Last Name', value: profile.lastName, enabled: enabled, onChanged: (v) => onChanged(profile.copyWith(lastName: v)))),
          SizedBox(width: 320, child: AppDateField(label: 'Date of Birth', value: profile.dateOfBirth, enabled: enabled, onChanged: (v) => onChanged(profile.copyWith(dateOfBirth: v)))),
          SizedBox(width: 320, child: AppTextField(label: 'Gender', value: profile.gender, enabled: enabled, onChanged: (v) => onChanged(profile.copyWith(gender: v)))),
          SizedBox(width: 320, child: AppTextField(label: 'Nationality Code', value: profile.nationalityCode, enabled: enabled, onChanged: (v) => onChanged(profile.copyWith(nationalityCode: v.toUpperCase())))),
        ],
      ),
    );
  }
}
