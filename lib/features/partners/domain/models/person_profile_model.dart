/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : person_profile_model.dart
 Purpose      : *   Models natural person profile data for Partner UI forms.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'model_helpers.dart';

class PersonProfileModel {
  const PersonProfileModel({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.nationalityCode,
  });

  final String? id;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? nationalityCode;

  factory PersonProfileModel.fromJson(Map<String, dynamic> json) => PersonProfileModel(
        id: json['id']?.toString(),
        firstName: json['first_name']?.toString(),
        middleName: json['middle_name']?.toString(),
        lastName: json['last_name']?.toString(),
        dateOfBirth: parseDate(json['date_of_birth']),
        gender: json['gender']?.toString(),
        nationalityCode: json['nationality_code']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'middle_name': middleName,
        'last_name': lastName,
        'date_of_birth': dateToJson(dateOfBirth),
        'gender': gender,
        'nationality_code': nationalityCode,
      };

  PersonProfileModel copyWith({
    String? id,
    String? firstName,
    String? middleName,
    String? lastName,
    DateTime? dateOfBirth,
    String? gender,
    String? nationalityCode,
  }) =>
      PersonProfileModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        nationalityCode: nationalityCode ?? this.nationalityCode,
      );
}
