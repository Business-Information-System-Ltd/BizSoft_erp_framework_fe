# BizSoft ERP Partner UI

## Overview

This feature implements the common Business Partner / Stakeholder master data UI for a Flutter web ERP application. It consumes the Django Partner API and intentionally does not implement Customer, Supplier, Employee, Fixed Asset Register, Finance, or other module-specific profiles.

## Screens

- `PartnerListScreen`: browse, search, filter, open detail, and open edit.
- `PartnerFormScreen`: create and edit partners using tabbed sections.
- `PartnerDetailScreen`: read-only summary and child-record browsing.

## Folder Structure

- `domain/enums`: Partner enum values and API mapping helpers.
- `domain/models`: Partner aggregate and child-record models.
- `data/services`: Dio API service.
- `data/repositories`: Repository pattern conversion layer.
- `presentation/providers`: Riverpod state and dependency providers.
- `presentation/widgets`: Reusable Partner form, lookup, chip, and child-section widgets.
- `presentation/screens`: Routed list, form, and detail screens.

## API

The UI expects these Django endpoints:

- `GET /api/partners/`
- `POST /api/partners/`
- `GET /api/partners/{id}/`
- `PUT /api/partners/{id}/`
- `PATCH /api/partners/{id}/`
- `POST /api/partners/{id}/activate/`
- `POST /api/partners/{id}/block/`
- `GET/POST /api/partners/{id}/{child-name}/`

Set the backend URL at run time:

```powershell
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

## Flow

The default route is `/partners`. The user can search and filter partners, create a new draft, edit an existing partner, activate it, block it, or view read-only detail. Child tabs are visible during create/edit, but child add actions are disabled until the Partner has been saved and has an id.

## Validation

The form validates required common fields before saving:

- Display Name
- Country Code
- Default Currency

Backend validation errors are normalized by `ApiClient` and shown through provider error state.

## State

Riverpod providers manage:

- `partnerListProvider`: list, filters, paging, loading, and error state.
- `partnerDetailProvider`: async detail fetch by id.
- `partnerFormProvider`: create/edit dirty state, save state, validation errors, success, activate, and block actions.
- `partnerRepositoryProvider` and `partnerApiServiceProvider`: dependency setup.

## Run

Install dependencies:

```powershell
flutter pub get
```

Run for web:

```powershell
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

## Routes

- `/partners`
- `/partners/new`
- `/partners/:id`
- `/partners/:id/edit`

## Future Extensions

- Add child-record create/edit dialogs for roles, addresses, contacts, registrations, identifications, relationships, and compliance.
- Add server-side sorting and page-size controls.
- Add audit/log panels.
- Add permission-based button visibility.
- Add module-specific navigation into Customer, Supplier, Employee, FAR, and Finance profiles after Partner activation.
## PartnerBasicInformation Extension Guide

`PartnerBasicInformation` is the reusable common identity/profile component for Business Partner onboarding. It captures only common partner data:

- Caller context
- Partner type
- Basic profile
- First identity on the flat form
- Additional identities
- Addresses
- Contact persons
- Duplicate check fields and results

It must not contain Supplier, Customer, Employee, Doctor, Patient, Bank, Consultant, Agent, accounting, payroll, credit-control, payment-term, or approval workflow fields.

### Standalone Partner Master

Use `PartnerBasicInformationScreen` for Common Setup > Partner Master.

Route examples:

```text
/partners
/partners/new
/partners/:id/edit
```

The standalone screen uses `BsMasterEntryPage`:

```dart
BsMasterEntryPage(
  routeMeta: BsMasterEntryRouteMeta(
    title: 'Partner Basic Information',
    moduleCode: 'COMMON',
    screenCode: 'PARTNER_BASIC_INFORMATION',
  ),
  basicInfo: PartnerBasicInformation(
    state: state,
    notifier: notifier,
    displayMode: PartnerBasicInformationDisplayMode.basicOnly,
  ),
  detailContent: PartnerBasicInformation(
    state: state,
    notifier: notifier,
    displayMode: PartnerBasicInformationDisplayMode.detailOnly,
  ),
)
```

### Embedded Supplier Example

Supplier entry should embed Partner basic information and add supplier-specific sections beside it.

```dart
PartnerBasicInformation(
  state: partnerState,
  notifier: partnerNotifier,
  isEmbeddedMode: true,
  showContextInfo: true,
)

SupplierProfileSection()
```

Supplier save flow:

```text
SupplierFormScreen
-> PartnerBasicInformation
-> SupplierProfileSection
-> SupplierFormProvider.save()
-> validate PartnerBasicInformation
-> validate SupplierProfile
-> build OnboardSupplierRequest
-> SupplierRepository.onboardSupplier()
-> POST /api/suppliers/onboard/
```

Do not call `PartnerBasicInformationApiService` directly from `SupplierFormScreen`.

### Embedded Customer Example

Customer entry should combine the same partner component with customer-specific sections:

```text
CustomerFormScreen
-> PartnerBasicInformation
-> CustomerProfileSection
-> Credit Control Section
-> Billing and Delivery Section
-> CustomerRepository.onboardCustomer()
-> POST /api/customers/onboard/
```

Customer-specific fields such as credit limit, price list, billing address rules, and delivery settings belong outside `PartnerBasicInformation`.

### Embedded Employee Example

Employee entry should preselect natural person when the onboarding context requires it:

```dart
PartnerBasicInformationCallerContext(
  callerProgram: 'Employee Entry',
  entryMode: 'EMPLOYEE',
  preselectedPartnerType: 'NATURAL_PERSON',
  preselectedRole: 'EMPLOYEE',
  preselectedRelationship: 'EMPLOYEE_OF',
  isPartnerTypeEditable: false,
  isEmbeddedMode: true,
)
```

Employee-specific fields such as payroll, work schedule, employment dates, and HR policies belong outside `PartnerBasicInformation`.

### Caller Context

Caller programs should initialize the provider with context:

```dart
notifier.initializeWithContext(
  PartnerBasicInformationCallerContext(
    callerProgram: 'Supplier Entry',
    entryMode: 'SUPPLIER',
    preselectedPartnerType: 'LEGAL_PERSON',
    preselectedRole: 'SUPPLIER',
    preselectedRelationship: 'SUPPLIER_OF',
    currentLegalEntityId: company.id,
    currentLegalEntityName: company.name,
    currentOrganizationUnitId: branchId,
    currentOrganizationUnitName: branchName,
    isPartnerTypeEditable: true,
    isEmbeddedMode: true,
  ),
);
```

Normal users should not manually edit role or relationship. The caller program or backend onboarding service decides them.

### Validation And Backend Authority

Frontend validation checks only immediate UI requirements:

- Partner Type required
- Display Name required
- First Identity Type required
- First Identity No. required
- Legal Person requires at least one contact person
- Contact Person Name and Phone No. required
- Only one primary identity/address/contact in local form state

Django remains the final authority for duplicate checking, role assignment, relationship creation, approval, conflict rules, permissions, and policy validation.

### Extension Rule

To add a new partner extension such as Doctor, Patient, Bank, Consultant, Agent, or Merchant:

1. Create a new feature folder.
2. Create an extension profile section widget.
3. Embed `PartnerBasicInformation`.
4. Initialize caller context with role/relationship.
5. Parent provider calls `validateForSave()` and `buildCreateRequest()`.
6. Parent repository calls the extension onboarding endpoint.
7. Keep extension-specific fields out of `PartnerBasicInformation`.
