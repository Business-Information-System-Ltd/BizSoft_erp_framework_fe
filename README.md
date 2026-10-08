# BizSoft Frontend Framework

## 1. Purpose

BizSoft Frontend Framework is a reusable Flutter foundation for BizSoft business applications. It provides standard widgets, routing, API communication, Riverpod providers, DTO/model/repository patterns, and sample screens so junior developers can build ERP, FAR, Partner, HR, Hospital, School, CRM, Audit, Workflow, and Reporting screens consistently.

## 2. Technology Stack

- Flutter
- Dart null safety
- Dio for HTTP API calls
- Riverpod for state management and dependency injection
- go_router for navigation, deep links, and web-friendly URLs
- intl for date and number formatting
- PlutoGrid for ERP-style grids and lookup tables

## 3. Naming Rule

Common reusable framework code uses the `Bs` prefix:

- `BsPage`
- `BsToolbar`
- `BsTextField`
- `BsLookupSearchBox`
- `BsPlutoGrid`
- `BsApiClient`

Module-specific widgets use the module prefix:

- `FarAssetBasicSection`
- `PartnerAddressSection`
- `HrEmployeeSelector`

Do not use `Erp` as the common framework prefix.

## 4. Folder Structure

- `lib/app`: application shell, theme, routes, route names, constants, config.
- `lib/core`: API client, providers, auth placeholders, config, utilities, validators.
- `lib/shared`: reusable layout, buttons, inputs, lookup, grid, search, filters, dialogs, feedback, status, attachment, audit widgets.
- `lib/modules`: real business modules such as Branch, Department, Currency, Partner, FAR.
- `lib/sample`: example pages for junior developers.

## 5. Architecture Flow

```text
UI Page
-> Riverpod Controller / Provider
-> Repository
-> ApiService
-> BsApiClient using Dio
-> Backend API
```

Rules:

- UI pages must not call Dio directly.
- UI pages must not parse raw JSON directly.
- Repositories return domain models.
- ApiServices return DTOs.
- Backend validation is final; frontend validation is for convenience.

## 6. Object Pattern

- DTO: API request/response object, for example `BranchDto`.
- Domain Model: app/business object, for example `Branch`.
- Mapper: converts DTO to domain model.
- ApiService: endpoint calls.
- Repository: use-case level data access.
- Controller/Provider: Riverpod screen state.
- Page: layout and user interaction only.

## 7. Routing Guide

- Routes are defined in `lib/app/bs_app_routes.dart`.
- Route names are in `lib/app/bs_route_names.dart`.
- Router provider is `bsRouterProvider`.
- Use `context.go('/path')` for navigation.
- Use path parameters for edit pages, for example `/common/branches/:id`.
- `BsShellLayout` provides the side menu and content area.
- Add new menu links in `lib/shared/layout/bs_side_menu.dart`.

## 8. How To Create A New Screen

1. Create a module folder under `lib/modules/<module>/<program>`.
2. Create DTO files under `data/dto`.
3. Create the domain model under `domain/model`.
4. Create a mapper under `data/mapper`.
5. Create an API service under `data/service`.
6. Create a repository under `data/repository`.
7. Create Riverpod controllers under `presentation/controller`.
8. Create pages under `presentation/page`.
9. Use only `Bs` widgets in pages where possible.
10. Register routes in `lib/app/bs_app_routes.dart`.
11. Add menu item in `BsSideMenu`.

## 9. How To Create An Entry Program

Use Branch as the golden example:

- Model: `lib/modules/common_setup/branch/domain/model/branch.dart`
- DTOs: `lib/modules/common_setup/branch/data/dto`
- Mapper: `lib/modules/common_setup/branch/data/mapper/branch_mapper.dart`
- API service: `lib/modules/common_setup/branch/data/service/branch_api_service.dart`
- Repository: `lib/modules/common_setup/branch/data/repository/branch_repository.dart`
- Form controller: `lib/modules/common_setup/branch/presentation/controller/branch_form_controller.dart`
- Form page: `lib/modules/common_setup/branch/presentation/page/branch_form_page.dart`
- Form section: `lib/modules/common_setup/branch/presentation/widget/branch_form_section.dart`

Basic form pattern:

```dart
BsPage(
  title: 'New Branch',
  toolbar: BsToolbar(children: [
    BsSaveButton(onPressed: save),
    BsCancelButton(onPressed: cancel),
  ]),
  body: BsSectionCard(
    title: 'Branch Information',
    child: BsTextField(
      label: 'Branch Code',
      controller: codeController,
      requiredField: true,
    ),
  ),
)
```

## 10. How To Create A Listing Program

Use Branch List as the golden example:

- Controller loads data from repository.
- Page watches controller with Riverpod.
- Data is displayed with `BsPlutoGrid`.
- New button navigates to the entry page.

Basic list pattern:

```dart
BsPage(
  title: 'Branches',
  toolbar: BsToolbar(children: [
    BsNewButton(onPressed: () => context.go('/common/branches/new')),
    BsRefreshButton(onPressed: refresh),
  ]),
  filterPanel: BsSearchBox(onSearch: search),
  body: BsPlutoGrid(columns: columns, rows: rows),
)
```

## 11. How To Create A New Reusable Program

When you create a reusable widget:

1. Put it under `lib/shared/<category>`.
2. Name it with `Bs` prefix, for example `BsAccountLookupField`.
3. Keep it business-neutral.
4. Accept configuration and callbacks from parent pages.
5. Do not hard-code FAR, Partner, Customer, Supplier, or Finance logic.
6. Use `Theme.of(context)` instead of hard-coded styling where possible.
7. Add a sample usage page under `lib/sample` if the widget is important.

## 12. Master Form Guide

Use:

- `BsPage`
- `BsToolbar`
- `BsSectionCard`
- `BsFormRow`
- `BsTextField`
- `BsDateField`
- `BsDropdownField`
- `BsSaveButton`
- `BsCancelButton`
- `BsValidationMessagePanel`
- `BsLoadingOverlay`

Do not use raw `TextFormField`, `DropdownButtonFormField`, `ElevatedButton`, or `AlertDialog` directly in business screens unless approved.

## 13. List Page Guide

Use:

- `BsPage`
- `BsToolbar`
- `BsSearchBox`
- `BsPlutoGrid`
- `BsStatusBadge`
- `BsEmptyState`
- `BsErrorState`

Search text can include patterns such as:

```text
Code: A* #and# Name: Yangon*
```

## 14. Lookup Field Guide

Use `BsLookupSearchBox` for large master data:

1. User types a keyword.
2. User presses `/`, `?`, Enter, or search icon.
3. Parent callback searches backend or mock data.
4. Results display in a PlutoGrid dialog.
5. Selected `id`, `code`, `displayText`, and `rawData` return to parent.

Use it for Asset, Customer, Supplier, Employee, GL Account, Item, and similar large lists.

## 15. Report Date Filter Guide

Use `BsReportDateFilter` for report screens.

Presets:

- Today
- Yesterday
- This Week
- This Month
- Previous Month
- Last 3 Months
- Last 6 Months
- This Year
- Specific Date Range

Preset dates are calculated automatically and shown read-only. Specific Date Range enables calendar selection. `minimumDate` and `maximumDate` can come from report configuration.

## 16. API Calling Rule

Never call Dio in a UI page. Use this flow:

```text
Page -> Controller -> Repository -> ApiService -> BsApiClient
```

`BsApiClient` handles base URL, headers, timeouts, interceptors, and normalized `BsApiException`.

## 17. Validation Rule

- Frontend validation helps the user.
- Backend validation is final.
- Show backend validation messages with `BsValidationMessagePanel`.
- Keep business validation in module services/controllers, not reusable input widgets.

## 18. How To Run

```powershell
flutter pub get
flutter analyze
flutter run -d chrome
```

With backend URL:

```powershell
flutter run -d chrome --dart-define=API_BASE_URL=http://localhost:8000
```

## 19. First Assignment For Juniors

Build these using the Branch golden example:

- Branch List Page
- Branch Form Page
- Department List Page
- Department Form Page
- Currency List Page
- Currency Form Page

Start with mock API services. Replace mock services with real backend calls after the UI flow is correct.
## Application Shell Standard

The BizSoft application shell is a compact Windows-style ERP frame used by all business pages.

```text
+--------------------------------------------------------------------------------+
| [Company Logo] Demo Company Ltd. v                    Notifications  ?  Theme  User v |
+--------------------------------------------------------------------------------+
| Side Menu      | Home > Common Setup > Branch                                  |
| collapsible    | Branch Master                                  [New] [Edit] |
|                | Main routed content                                           |
|                |                                                [Cancel] [Save] |
+--------------------------------------------------------------------------------+
| Validation/Error message          BizSoft ERP System              2026-06-11 15:42:18 |
+--------------------------------------------------------------------------------+
```

Rules:

1. Current company is shown at upper-left.
2. Click company logo/name to change company.
3. Company list is filtered by the current user's company permissions.
4. Footer lower-left is temporary validation/error/status message area.
5. Footer lower-center shows system/application name.
6. Footer lower-right shows only active date/time clock.
7. Date/time format comes from selected company setup.
8. Clock updates every second.
9. Left side menu can be collapsed/expanded.
10. Breadcrumb is below header and above page header.
11. New/Edit/Delete/Refresh actions are upper-right.
12. Save/Cancel/Apply/Close actions are lower-right.
13. Theme can be changed from header.
14. Theme should be compact, Windows-like, professional ERP style.
15. Avoid hard-coded colors and large rounded corners.

### Shell Components

- `BsAppShell`: Main shell used by the `go_router` `ShellRoute`.
- `BsHeaderBar`: Menu toggle, company identity selector, notifications, help, theme switcher, and user menu.
- `BsSideMenu`: Collapsible role-sensitive left navigation.
- `BsMainContentArea`: Routed page content container.
- `BsFooterBar`: Footer message area, system name, and active live clock.
- `BsBreadcrumb`: Navigation path below header and above page title.

### Current Company Selector

`BsCompanyIdentitySelector` reads:

- `bsSelectedCompanyProvider`
- `bsAllowedCompaniesProvider`

`bsAllowedCompaniesProvider` filters companies using `bsCurrentUserProvider.allowedCompanyIds`.

The first version uses mock companies:

- `BIZSOFT` / BizSoft Systems / Asia/Yangon
- `DEMO` / Demo Company Ltd. / Asia/Yangon
- `SGDEMO` / Singapore Demo Company / Asia/Singapore

Company switching changes only the current working company for this session. It does not save the selected company as the user's default.

### How To Show Footer Message From A Screen

Use the shell footer message provider instead of normal `SnackBar` for standard ERP validation/status messages.

```dart
ref.read(bsFooterMessageProvider.notifier).showValidation('Asset Code is required.');
ref.read(bsFooterMessageProvider.notifier).showError('Save failed. Please try again.');
ref.read(bsFooterMessageProvider.notifier).showSuccess('Asset saved successfully.');
```

### How To Add A Menu Item

1. Add route in `bs_app_routes.dart`.
2. Add route name in `bs_route_names.dart`.
3. Add menu item in `BsMenuService`.
4. Assign `permissionCode`.
5. Ensure current user has permission.

Example:

```dart
BsMenuItem(
  title: 'New Report',
  routePath: '/reports/new-report',
  icon: Icons.description_outlined,
  permissionCode: 'REPORT.NEW_REPORT.VIEW',
)
```

### How To Add Breadcrumb

Use `BsBreadcrumb` with a list of `BsBreadcrumbItem` values.

```dart
BsBreadcrumb(
  items: [
    BsBreadcrumbItem(label: 'Home', routePath: '/'),
    BsBreadcrumbItem(label: 'Common Setup'),
    BsBreadcrumbItem(label: 'Branch'),
  ],
)
```

Breadcrumb is for navigation path only. Workflow status belongs in page header status or a workflow action area.

### Page And Form Action Placement

Upper-right page/document actions:

- New
- Edit
- Delete
- Refresh
- Print
- Export
- More

Lower-right form commit actions:

- Save
- Cancel
- Submit
- Apply
- Close

Do not place Save in the upper toolbar for normal form screens. Use `BsFormActionBar` at the lower-right of the form page.

### Theme Changing

`BsThemeSwitcher` updates `bsThemeModeProvider`.

`BsApp` passes this value to `MaterialApp.router`:

```dart
theme: BsAppTheme.lightTheme,
darkTheme: BsAppTheme.darkTheme,
themeMode: themeMode,
```

The first version stores the theme mode in memory. Later, persist it using local storage or backend user preference.

### Backend Replacement Guide

Keep widget/provider names stable and replace mock service implementations later:

- Replace `BsCompanyService.getCompanies()` with backend company data.
- Replace `BsMenuService.getMenuItems()` with backend or role-profile menu data.
- Replace `BsNotificationService.getNotifications()` with backend notifications.
- Replace `bsCurrentUserProvider` mock data with authenticated user state.

Shell widgets should not call Dio or backend APIs directly.

## Application Shell Standard

The BizSoft application shell is a compact Windows-style ERP frame used by all business pages.

```text
+--------------------------------------------------------------------------------+
| [Company Logo] Demo Company Ltd. v                    Notifications  ?  Theme  User v |
+--------------------------------------------------------------------------------+
| Side Menu      | Home > Common Setup > Branch                                  |
| collapsible    | Branch Master                                  [New] [Edit] |
|                | Main routed content                                           |
|                |                                                [Cancel] [Save] |
+--------------------------------------------------------------------------------+
| Validation/Error message          BizSoft ERP System              2026-06-11 15:42:18 |
+--------------------------------------------------------------------------------+
```

Rules:

1. Current company is shown at upper-left.
2. Click company logo/name to change company.
3. Company list is filtered by the current user's company permissions.
4. Footer lower-left is temporary validation/error/status message area.
5. Footer lower-center shows system/application name.
6. Footer lower-right shows only active date/time clock.
7. Date/time format comes from selected company setup.
8. Clock updates every second.
9. Left side menu can be collapsed/expanded.
10. Breadcrumb is below header and above page header.
11. New/Edit/Delete/Refresh actions are upper-right.
12. Save/Cancel/Apply/Close actions are lower-right.
13. Theme can be changed from header.
14. Theme should be compact, Windows-like, professional ERP style.
15. Avoid hard-coded colors and large rounded corners.

### Shell Components

- `BsAppShell`: Main shell used by the `go_router` `ShellRoute`.
- `BsHeaderBar`: Menu toggle, company identity selector, notifications, help, theme switcher, and user menu.
- `BsSideMenu`: Collapsible role-sensitive left navigation.
- `BsMainContentArea`: Routed page content container.
- `BsFooterBar`: Footer message area, system name, and active live clock.
- `BsBreadcrumb`: Navigation path below header and above page title.

### Current Company Selector

`BsCompanyIdentitySelector` reads:

- `bsSelectedCompanyProvider`
- `bsAllowedCompaniesProvider`

`bsAllowedCompaniesProvider` filters companies using `bsCurrentUserProvider.allowedCompanyIds`.

The first version uses mock companies:

- `BIZSOFT` / BizSoft Systems / Asia/Yangon
- `DEMO` / Demo Company Ltd. / Asia/Yangon
- `SGDEMO` / Singapore Demo Company / Asia/Singapore

Company switching changes only the current working company for this session. It does not save the selected company as the user's default.

### How To Show Footer Message From A Screen

Use the shell footer message provider instead of normal `SnackBar` for standard ERP validation/status messages.

```dart
ref.read(bsFooterMessageProvider.notifier).showValidation('Asset Code is required.');
ref.read(bsFooterMessageProvider.notifier).showError('Save failed. Please try again.');
ref.read(bsFooterMessageProvider.notifier).showSuccess('Asset saved successfully.');
```

### How To Add A Menu Item

1. Add route in `bs_app_routes.dart`.
2. Add route name in `bs_route_names.dart`.
3. Add menu item in `BsMenuService`.
4. Assign `permissionCode`.
5. Ensure current user has permission.

Example:

```dart
BsMenuItem(
  title: 'New Report',
  routePath: '/reports/new-report',
  icon: Icons.description_outlined,
  permissionCode: 'REPORT.NEW_REPORT.VIEW',
)
```

### How To Add Breadcrumb

Use `BsBreadcrumb` with a list of `BsBreadcrumbItem` values.

```dart
BsBreadcrumb(
  items: [
    BsBreadcrumbItem(label: 'Home', routePath: '/'),
    BsBreadcrumbItem(label: 'Common Setup'),
    BsBreadcrumbItem(label: 'Branch'),
  ],
)
```

Breadcrumb is for navigation path only. Workflow status belongs in page header status or a workflow action area.

### Page And Form Action Placement

Upper-right page/document actions:

- New
- Edit
- Delete
- Refresh
- Print
- Export
- More

Lower-right form commit actions:

- Save
- Cancel
- Submit
- Apply
- Close

Do not place Save in the upper toolbar for normal form screens. Use `BsFormActionBar` at the lower-right of the form page.

### Theme Changing

`BsThemeSwitcher` updates `bsThemeModeProvider`.

`BsApp` passes this value to `MaterialApp.router`:

```dart
theme: BsAppTheme.lightTheme,
darkTheme: BsAppTheme.darkTheme,
themeMode: themeMode,
```

The first version stores the theme mode in memory. Later, persist it using local storage or backend user preference.

### Backend Replacement Guide

Keep widget/provider names stable and replace mock service implementations later:

- Replace `BsCompanyService.getCompanies()` with backend company data.
- Replace `BsMenuService.getMenuItems()` with backend or role-profile menu data.
- Replace `BsNotificationService.getNotifications()` with backend notifications.
- Replace `bsCurrentUserProvider` mock data with authenticated user state.

Shell widgets should not call Dio or backend APIs directly.
## BsMasterEntryPage Usage Guideline

`BsMasterEntryPage` is the standard layout for ERP master-entry screens where the top part contains identity fields and the lower part contains tabbed or accordion detail information.

Use it for records such as Department, Branch, Asset Category, Customer, Supplier, Item, Warehouse, and similar master data.

### Layout Responsibilities

`BsMasterEntryPage` controls layout only:

- `routeMeta`: page title, subtitle, breadcrumb, module code, screen code, and optional record id.
- `pageActions`: upper-right page/document actions such as New, Edit, Delete, Refresh, Print, Export, More.
- `basicInfo`: always-visible required identity fields such as Code, Name, Branch, Status.
- `detailContent`: tabbed, accordion, grid/list, attachment, or audit detail content.
- `formActions`: lower-right commit actions such as Cancel and Save.
- `isLoading`: shows page loading overlay.
- `isDirty`: shows unsaved state and supports dirty guard foundations.

The widget must not contain module-specific fields, validations, repository calls, or API calls.

### Department Example Pattern

```text
DepartmentFormPage
-> DepartmentFormController
-> DepartmentFormState
-> DepartmentRepository
-> DepartmentApiService
```

The Department page supplies:

- `DepartmentBasicInfoSection`
- `BsTabbedDetailArea`
- `BsDetailTab`
- Save and Cancel callbacks
- Validation and dirty-state updates through `DepartmentFormController`

### Basic Usage

```dart
BsMasterEntryPage(
  routeMeta: BsMasterEntryRouteMeta(
    title: 'New Department',
    moduleCode: 'COMMON',
    screenCode: 'DEPARTMENT',
    breadcrumb: BsBreadcrumb(
      items: [
        BsBreadcrumbItem(label: 'Home', routePath: '/'),
        BsBreadcrumbItem(label: 'Common Setup'),
        BsBreadcrumbItem(label: 'Department'),
      ],
    ),
  ),
  pageActions: [
    BsNewButton(onPressed: openNew),
  ],
  basicInfo: DepartmentBasicInfoSection(...),
  detailContent: BsTabbedDetailArea(
    tabs: [
      BsDetailTab(title: 'General', child: generalSection),
      BsDetailTab(title: 'Responsibility', child: responsibilitySection),
      BsDetailTab(title: 'Related Accounts', child: accountsGrid),
      BsDetailTab(title: 'Attachments', child: attachmentsSection),
    ],
  ),
  formActions: BsFormActionBar(
    cancelButton: BsCancelButton(onPressed: cancel),
    saveButton: BsSaveButton(onPressed: save),
  ),
  isLoading: state.loading || state.saving,
  isDirty: state.isDirty,
)
```

### Detail Area Widgets

Use these reusable widgets inside `detailContent`:

- `BsTabbedDetailArea`: standard tabbed detail container.
- `BsDetailTab`: one tab definition.
- `BsAccordionDetailArea`: accordion container for grouped detail sections.
- `BsAccordionSection`: one accordion section definition.
- `BsDetailSection`: compact bordered detail section.
- `BsDetailGridSection`: fixed-height grid/list section for child grids or list widgets.

Tabs and accordions can contain grids, lists, attachment sections, audit trail sections, or module-specific reusable widgets.

### Dirty State Rule

Each module controller owns dirty state.

When a field changes:

```dart
state = state.copyWith(code: value, isDirty: true);
```

After successful save:

```dart
state = state.copyWith(isDirty: false);
```

Use `BsFormDirtyGuard.confirmDiscard` before Cancel, New, menu navigation, company switching, or opening another record.

```dart
final canLeave = await BsFormDirtyGuard.confirmDiscard(
  context,
  isDirty: state.isDirty,
);
```

First version supports page-level guard calls. Global menu, company-switching, and browser-route guards are marked as TODO until the shell navigation lifecycle is finalized.

### Draft Foundation

Use `BsFormSessionKey` to identify a form session:

```dart
BsFormSessionKey(
  companyId: company.id,
  userId: user.userId,
  moduleCode: 'COMMON',
  screenCode: 'DEPARTMENT',
  recordId: departmentId,
)
```

`BsFormDraftService` currently stores drafts in memory. Future improvements:

- Persist low-risk drafts with `shared_preferences` or browser storage.
- Save important transaction drafts to backend draft APIs.

### Rules

- Do not hard-code module fields inside `BsMasterEntryPage`.
- Do not call API services or repositories from `BsMasterEntryPage`.
- Keep validation and save logic inside module controllers/services.
- Use `BsTextField`, `BsDropdownField`, `BsFormActionBar`, and other BizSoft reusable widgets in module pages.
- Keep Save/Cancel in `formActions`, not in `pageActions`.
