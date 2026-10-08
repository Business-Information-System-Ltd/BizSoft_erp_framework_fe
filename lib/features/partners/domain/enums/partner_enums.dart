/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_enums.dart
 Purpose      : *   Defines Partner module enum values and JSON helpers.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
enum PartnerType { naturalPerson, legalPerson, governmentBody, internalOrganization }

enum PartnerStatus { draft, active, blocked, inactive }

enum PartnerRoleType { customer, supplier, employee, bank, taxAuthority, other }

extension PartnerTypeJson on PartnerType {
  String get value => switch (this) {
        PartnerType.naturalPerson => 'NATURAL_PERSON',
        PartnerType.legalPerson => 'LEGAL_PERSON',
        PartnerType.governmentBody => 'GOVERNMENT_BODY',
        PartnerType.internalOrganization => 'INTERNAL_ORGANIZATION',
      };

  String get label => switch (this) {
        PartnerType.naturalPerson => 'Natural Person',
        PartnerType.legalPerson => 'Legal Person',
        PartnerType.governmentBody => 'Government Body',
        PartnerType.internalOrganization => 'Internal Organization',
      };

  static PartnerType fromJson(String? value) => PartnerType.values.firstWhere(
        (item) => item.value == value,
        orElse: () => PartnerType.legalPerson,
      );
}

extension PartnerStatusJson on PartnerStatus {
  String get value => switch (this) {
        PartnerStatus.draft => 'DRAFT',
        PartnerStatus.active => 'ACTIVE',
        PartnerStatus.blocked => 'BLOCKED',
        PartnerStatus.inactive => 'INACTIVE',
      };

  String get label => switch (this) {
        PartnerStatus.draft => 'Draft',
        PartnerStatus.active => 'Active',
        PartnerStatus.blocked => 'Blocked',
        PartnerStatus.inactive => 'Inactive',
      };

  static PartnerStatus fromJson(String? value) => PartnerStatus.values.firstWhere(
        (item) => item.value == value,
        orElse: () => PartnerStatus.draft,
      );
}

extension PartnerRoleTypeJson on PartnerRoleType {
  String get value => switch (this) {
        PartnerRoleType.customer => 'CUSTOMER',
        PartnerRoleType.supplier => 'SUPPLIER',
        PartnerRoleType.employee => 'EMPLOYEE',
        PartnerRoleType.bank => 'BANK',
        PartnerRoleType.taxAuthority => 'TAX_AUTHORITY',
        PartnerRoleType.other => 'OTHER',
      };

  String get label => switch (this) {
        PartnerRoleType.customer => 'Customer',
        PartnerRoleType.supplier => 'Supplier',
        PartnerRoleType.employee => 'Employee',
        PartnerRoleType.bank => 'Bank',
        PartnerRoleType.taxAuthority => 'Tax Authority',
        PartnerRoleType.other => 'Other',
      };

  static PartnerRoleType fromJson(String? value) => PartnerRoleType.values.firstWhere(
        (item) => item.value == value,
        orElse: () => PartnerRoleType.other,
      );
}
