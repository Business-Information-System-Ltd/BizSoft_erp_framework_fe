import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/partners/presentation/screens/partner_basic_information_screen.dart';
import '../features/suppliers/presentation/screens/supplier_form_screen.dart';

// import '../modules/common_setup/branch/presentation/page/branch_form_page.dart';
import '../modules/common_setup/branch/presentation/page/branch_form_page.dart';
import '../modules/far/far_asset/presentation/page/far_asset_form_page.dart';
import '../modules/common_setup/branch/presentation/page/branch_list_page.dart';
// import '../modules/common_setup/branch/presentation/page/branch_view_page.dart';
import '../modules/common_setup/branch/presentation/page/branch_view_page.dart';
// import '../modules/far/far_asset/presentation/page/far_asset_form_page.dart';
import '../modules/far/far_asset/presentation/page/far_asset_list_page.dart';
// import '../modules/far/far_asset/presentation/page/far_asset_view_page.dart';
// import '../modules/common_setup/currency/presentation/page/currency_form_page.dart';
// import '../modules/common_setup/currency/presentation/page/currency_list_page.dart';
// import '../modules/common_setup/department/presentation/page/department_form_page.dart';
// import '../modules/common_setup/department/presentation/page/department_list_page.dart';

// import '../modules/far/report/far_asset_register_report_page.dart';
// import '../modules/far/transaction/far_asset_transaction_list_page.dart';
import '../modules/settings/settings_profile_page.dart';
import '../modules/settings/settings_system_page.dart';
import '../sample/sample_home_page.dart';
import '../sample/material_widgets_gallery_page.dart';
import '../sample/sample_lookup_page.dart';
import '../sample/sample_master_form_page.dart';
import '../sample/sample_master_list_page.dart';
import '../sample/sample_report_page.dart';
import '../shared/layout/bs_app_shell.dart';
import 'bs_route_names.dart';

class BsAppRoutes {
  const BsAppRoutes._();

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        
        return null;
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) => BsAppShell(child: child),
          routes: [
            GoRoute(
              name: BsRouteNames.home,
              path: '/',
              builder: (context, state) => const SampleHomePage(),
            ),
            GoRoute(
              name: BsRouteNames.sampleMasterList,
              path: '/sample/master-list',
              builder: (context, state) => const SampleMasterListPage(),
            ),
            GoRoute(
              name: BsRouteNames.sampleMasterForm,
              path: '/sample/master-form',
              builder: (context, state) => const SampleMasterFormPage(),
            ),
            GoRoute(
              name: BsRouteNames.sampleLookup,
              path: '/sample/lookup',
              builder: (context, state) => const SampleLookupPage(),
            ),
            GoRoute(
              name: BsRouteNames.sampleReport,
              path: '/sample/report',
              builder: (context, state) => const SampleReportPage(),
            ),
            GoRoute(
              name: BsRouteNames.sampleMaterialWidgets,
              path: '/sample/material-widgets',
              builder: (context, state) => const MaterialWidgetsGalleryPage(),
            ),
            GoRoute(
              name: BsRouteNames.partnerMaster,
              path: '/partners',
              builder: (context, state) =>
                  const PartnerBasicInformationScreen(),
            ),
            GoRoute(
              name: BsRouteNames.partnerBasicInformation,
              path: '/partners/new',
              builder: (context, state) =>
                  const PartnerBasicInformationScreen(),
            ),
            GoRoute(
              path: '/partners/:id/edit',
              builder: (context, state) => PartnerBasicInformationScreen(
                partnerId: state.pathParameters['id'],
              ),
            ),
            GoRoute(
              name: BsRouteNames.supplierEntry,
              path: '/suppliers',
              builder: (context, state) => const SupplierFormScreen(),
            ),
            GoRoute(
              path: '/suppliers/new',
              builder: (context, state) => const SupplierFormScreen(),
            ),
            GoRoute(
              path: '/suppliers/:id/edit',
              builder: (context, state) =>
                  SupplierFormScreen(supplierId: state.pathParameters['id']),
            ),
            GoRoute(
              name: BsRouteNames.branchList,
              path: '/common/branches',
              builder: (context, state) => const BranchListPage(),
            ),
            GoRoute(
              path: '/common/branches/new',
              builder: (context, state) {
                return const BranchFormPage();
              },
            ),
            GoRoute(
              path: '/common/branches/:id',
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '');

                if (id == null) {
                  return const Scaffold(
                    body: Center(child: Text('Invalid branch ID')),
                  );
                }

                return BranchViewPage(branchId: id);
              },
            ),

            GoRoute(
              path: '/common/branches/:id/edit',
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '');

                if (id == null) {
                  return const Scaffold(
                    body: Center(child: Text('Invalid branch ID')),
                  );
                }

                return BranchFormPage(branchId: id);
              },
            ),
            GoRoute(
              path: '/far/assets',
              builder: (context, state) => const FarAssetListPage(),
            ),
            // GoRoute(
            //   name: BsRouteNames.departmentList,
            //   path: '/common/departments',
            //   builder: (context, state) => const DepartmentListPage(),
            // ),
            // GoRoute(
            //   name: BsRouteNames.departmentForm,
            //   path: '/common/departments/new',
            //   builder: (context, state) => const DepartmentFormPage(),
            // ),
            // GoRoute(
            //   path: '/common/departments/:id',
            //   builder: (context, state) =>
            //       DepartmentFormPage(id: state.pathParameters['id']),
            // ),
            // GoRoute(
            //   name: BsRouteNames.currencyList,
            //   path: '/common/currencies',
            //   builder: (context, state) => const CurrencyListPage(),
            // ),
            // GoRoute(
            //   name: BsRouteNames.currencyForm,
            //   path: '/common/currencies/new',
            //   builder: (context, state) => const CurrencyFormPage(),
            // ),
            //             GoRoute(
            //               name: BsRouteNames.farAssetList,
            //               path: '/far/assets',
            //               builder: (context, state) => const FarAssetListPage(),
            //             ),
            //             GoRoute(
            //               name: BsRouteNames.farAssetForm,
            //               path: '/far/assets/new',
            //               builder: (context, state) => const FarAssetFormPage(),
            //             ),
            //             GoRoute(
            //               path: '/far/assets/:id',
            //               builder: (context, state) =>
            //                   FarAssetFormPage(assetId: state.pathParameters['id']),
            //             ),

            //             GoRoute(
            //               path: '/far/assets/:id/edit',
            //               builder: (context, state) {
            //               final id = int.tryParse(state.pathParameters['id'] ?? '');
            //               return FarAssetFormPage(assetId: id);
            //   },
            // ),
            // GoRoute(
            //   path: '/far/assets/:id',
            //   builder: (context, state) {
            //     final id = int.tryParse(state.pathParameters['id'] ?? '');
            //     return FarAssetViewPage(assetId: id!);
            //   },
            // ),
            // GoRoute(
            //   name: BsRouteNames.farAssetTransactions,
            //   path: '/far/transactions',
            //   builder: (context, state) => const FarAssetTransactionListPage(),
            // ),
            // GoRoute(
            //   name: BsRouteNames.farAssetRegisterReport,
            //   path: '/far/reports/asset-register',
            //   builder: (context, state) => const FarAssetRegisterReportPage(),
            // ),
            // FAR Asset List
            // GoRoute(
            //   path: '/far/assets',
            //   builder: (context, state) => const FarAssetListPage(),
            // ),
            GoRoute(
              name: BsRouteNames.farAssetList,
              path: '/common/branches',
              builder: (context, state) => const FarAssetListPage(),
            ),

            // FAR Asset — New (Form)
            GoRoute(
              path: '/far/assets/new',
              builder: (context, state) => const FarAssetFormPage(),
            ),

            // FAR Asset — Edit (Form)
            GoRoute(
              path: '/far/assets/:id/edit',
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '');
                return FarAssetFormPage(assetId: id);
              },
            ),

            // FAR Asset — View
            // GoRoute(
            //   path: '/far/assets/:id',
            //   builder: (context, state) {
            //     final id = int.tryParse(state.pathParameters['id'] ?? '');
            //     return FarAssetViewPage(assetId: id!);
            //   },
            // ),
            GoRoute(
              name: BsRouteNames.settingsProfile,
              path: '/settings/profile',
              builder: (context, state) => const SettingsProfilePage(),
            ),
            GoRoute(
              name: BsRouteNames.settingsSystem,
              path: '/settings/system',
              builder: (context, state) => const SettingsSystemPage(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        body: Center(child: Text(state.error?.toString() ?? 'Page not found')),
      ),
    );
  }
}
