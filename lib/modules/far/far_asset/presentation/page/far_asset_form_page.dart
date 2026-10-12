// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // import '../controller/far_asset_form_controller.dart';
// // // // import '../controller/far_asset_dropdown_providers.dart';

// // // import 'package:bizsoft_frontend_framework/core/widgets/app_text_field.dart';
// // // import 'package:bizsoft_frontend_framework/core/widgets/app_dropdown.dart';
// // // import 'package:bizsoft_frontend_framework/core/widgets/app_date_field.dart';
// // // import 'package:bizsoft_frontend_framework/core/widgets/app_section_card.dart';
// // // import 'package:bizsoft_frontend_framework/core/widgets/fixed_bottom_action_bar.dart';
// // // import 'package:bizsoft_frontend_framework/core/widgets/context_info_line.dart';
// // // import 'package:bizsoft_frontend_framework/core/widgets/compact_erp_tab_bar.dart';

// // // class FarAssetFormPage extends ConsumerStatefulWidget {
// // //   final int? assetId;
// // //   const FarAssetFormPage({super.key, this.assetId});

// // //   @override
// // //   ConsumerState<FarAssetFormPage> createState() => _FarAssetFormPageState();
// // // }

// // // class _FarAssetFormPageState extends ConsumerState<FarAssetFormPage>
// // //     with SingleTickerProviderStateMixin {
// // //   late TabController _tabController;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _tabController = TabController(length: 4, vsync: this);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _tabController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final state = ref.watch(farAssetFormControllerProvider(widget.assetId));
// // //     final controller = ref.read(
// // //       farAssetFormControllerProvider(widget.assetId).notifier,
// // //     );

// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFFF5F6F8),
// // //       body: state.loading
// // //           ? const Center(child: CircularProgressIndicator())
// // //           : Column(
// // //               children: [
// // //                 _buildHeader(state),
// // //                 Expanded(
// // //                   child: ListView(
// // //                     padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
// // //                     children: [
// // //                       _buildBasicInfoCard(state, controller),
// // //                       const SizedBox(height: 12),
// // //                       _buildTabbedCard(state, controller),
// // //                       const SizedBox(height: 12),
// // //                       if (state.validationMessages.isNotEmpty)
// // //                         _buildValidationPanel(state),
// // //                     ],
// // //                   ),
// // //                 ),
// // //                 _buildActionBar(state, controller),
// // //               ],
// // //             ),
// // //     );
// // //   }

// // //   Widget _buildHeader(FarAssetFormState state) {
// // //     return Container(
// // //       color: Colors.white,
// // //       padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: const [
// // //               Text(
// // //                 'Home',
// // //                 style: TextStyle(
// // //                   fontSize: 12,
// // //                   color: Color(0xFF0B49A5),
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //               Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: 6),
// // //                 child: Icon(
// // //                   Icons.chevron_right,
// // //                   size: 14,
// // //                   color: Color(0xFF9CA3AF),
// // //                 ),
// // //               ),
// // //               Text(
// // //                 'Fixed Assets Register',
// // //                 style: TextStyle(
// // //                   fontSize: 12,
// // //                   color: Color(0xFF0B49A5),
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //               Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: 6),
// // //                 child: Icon(
// // //                   Icons.chevron_right,
// // //                   size: 14,
// // //                   color: Color(0xFF9CA3AF),
// // //                 ),
// // //               ),
// // //               Text(
// // //                 'Core Entity Entry',
// // //                 style: TextStyle(
// // //                   fontSize: 12,
// // //                   color: Color(0xFF0B49A5),
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //               Padding(
// // //                 padding: EdgeInsets.symmetric(horizontal: 6),
// // //                 child: Icon(
// // //                   Icons.chevron_right,
// // //                   size: 14,
// // //                   color: Color(0xFF9CA3AF),
// // //                 ),
// // //               ),
// // //               Text(
// // //                 'New',
// // //                 style: TextStyle(
// // //                   fontSize: 12,
// // //                   color: Color(0xFF6B7280),
// // //                   fontWeight: FontWeight.w600,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 12),

// // //           Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             crossAxisAlignment: CrossAxisAlignment.center,
// // //             children: [
// // //               Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: const [
// // //                   Text(
// // //                     'Fixed Asset Entry',
// // //                     style: TextStyle(
// // //                       fontSize: 22,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: Color(0xFF1F2937),
// // //                     ),
// // //                   ),
// // //                   SizedBox(height: 4),
// // //                   Text(
// // //                     'Create fixed asset profile',
// // //                     style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
// // //                   ),
// // //                 ],
// // //               ),
// // //               OutlinedButton.icon(
// // //                 onPressed: () => _checkDuplicate(state),
// // //                 icon: const Icon(
// // //                   Icons.search,
// // //                   size: 16,
// // //                   color: Color(0xFF0B49A5),
// // //                 ),
// // //                 label: const Text(
// // //                   'Check Duplicate',
// // //                   style: TextStyle(
// // //                     fontSize: 13,
// // //                     color: Color(0xFF0B49A5),
// // //                     fontWeight: FontWeight.w500,
// // //                   ),
// // //                 ),
// // //                 style: OutlinedButton.styleFrom(
// // //                   padding: const EdgeInsets.symmetric(
// // //                     horizontal: 8,
// // //                     vertical: 4,
// // //                   ),
// // //                   side: const BorderSide(color: Color(0xFF0B49A5), width: 0.6),
// // //                   shape: RoundedRectangleBorder(
// // //                     borderRadius: BorderRadius.circular(4),
// // //                   ),
// // //                   foregroundColor: const Color(0xFF0B49A5),
// // //                   backgroundColor: Colors.transparent,
// // //                   elevation: 0,
// // //                   minimumSize: const Size(0, 36),
// // //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 12),

// // //           Row(
// // //             crossAxisAlignment: CrossAxisAlignment.center,
// // //             children: [
// // //               Expanded(
// // //                 child: ContextInfoLine(
// // //                   items: [
// // //                     ContextInfoLineItem(
// // //                       label: 'Draft No',
// // //                       value: state.draftNo,
// // //                       priority: 1,
// // //                     ),
// // //                     ContextInfoLineItem(
// // //                       label: 'Source',
// // //                       value: state.source,
// // //                       priority: 2,
// // //                     ),
// // //                     ContextInfoLineItem(
// // //                       label: 'Draft Date',
// // //                       value: _fmtDate(state.draftDate),
// // //                       priority: 3,
// // //                     ),
// // //                     ContextInfoLineItem(
// // //                       label: 'Prepared By',
// // //                       value: state.preparedBy,
// // //                       priority: 4,
// // //                     ),
// // //                     ContextInfoLineItem(
// // //                       label: 'Last Updated',
// // //                       value: _fmtDateTime(state.lastUpdated),
// // //                       priority: 5,
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Row(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 children: [
// // //                   const Text(
// // //                     'Status: ',
// // //                     style: TextStyle(
// // //                       fontSize: 12,
// // //                       color: Color(0xFF6B7280),
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                   ),
// // //                   Text(
// // //                     state.status,
// // //                     style: const TextStyle(
// // //                       fontSize: 12,
// // //                       color: Color(0xFF1F2937),
// // //                       fontWeight: FontWeight.bold,
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Future<void> _checkDuplicate(FarAssetFormState state) async {
// // //     if (state.assetName.trim().isEmpty) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('Please enter Asset Name first'),
// // //           backgroundColor: Colors.orange,
// // //         ),
// // //       );
// // //       return;
// // //     }

// // //     showDialog(
// // //       context: context,
// // //       builder: (ctx) => AlertDialog(
// // //         title: const Row(
// // //           children: [
// // //             Icon(Icons.search, color: Color(0xFF0B49A5)),
// // //             SizedBox(width: 8),
// // //             Text('Check Duplicate'),
// // //           ],
// // //         ),
// // //         content: SizedBox(
// // //           width: 400,
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const Text(
// // //                 'Checking for duplicate entries...',
// // //                 style: TextStyle(fontSize: 13),
// // //               ),
// // //               const SizedBox(height: 16),
// // //               _dupCheckRow('Asset Name', state.assetName),
// // //               _dupCheckRow('Description', state.description ?? '-'),
// // //               _dupCheckRow('Asset Type *', state.assetType ?? '-'),
// // //               _dupCheckRow('Serial No', state.serialNumber ?? '-'),
// // //               _dupCheckRow('Brand', state.brand ?? '-'),
// // //               _dupCheckRow('Model', state.model ?? '-'),
// // //               _dupCheckRow('Quality', state.unit ?? '-'),
// // //               _dupCheckRow('Unit', state.unit ?? '-'),
// // //               const SizedBox(height: 16),
// // //               Container(
// // //                 padding: const EdgeInsets.all(12),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.green.shade50,
// // //                   border: Border.all(color: Colors.green.shade300, width: 0.8),
// // //                   borderRadius: BorderRadius.circular(4),
// // //                 ),
// // //                 child: Row(
// // //                   children: [
// // //                     Icon(
// // //                       Icons.check_circle,
// // //                       color: Colors.green.shade700,
// // //                       size: 20,
// // //                     ),
// // //                     const SizedBox(width: 8),
// // //                     const Text(
// // //                       'No duplicates found',
// // //                       style: TextStyle(
// // //                         fontSize: 13,
// // //                         color: Colors.green,
// // //                         fontWeight: FontWeight.w600,
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(ctx),
// // //             child: const Text('Close'),
// // //           ),
// // //           ElevatedButton(
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: const Color(0xFF0B49A5),
// // //               foregroundColor: Colors.white,
// // //             ),
// // //             onPressed: () {
// // //               Navigator.pop(ctx);
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 const SnackBar(
// // //                   content: Text('No duplicate found — you can save'),
// // //                   backgroundColor: Colors.green,
// // //                 ),
// // //               );
// // //             },
// // //             child: const Text('OK'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _dupCheckRow(String label, String value) {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(vertical: 3),
// // //       child: Row(
// // //         children: [
// // //           SizedBox(
// // //             width: 100,
// // //             child: Text(
// // //               '$label:',
// // //               style: const TextStyle(
// // //                 fontSize: 12,
// // //                 color: Color(0xFF6B7280),
// // //                 fontWeight: FontWeight.w500,
// // //               ),
// // //             ),
// // //           ),
// // //           Expanded(
// // //             child: Text(
// // //               value.isEmpty ? '-' : value,
// // //               style: const TextStyle(
// // //                 fontSize: 12,
// // //                 color: Color(0xFF1F2937),
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildBasicInfoCard(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return AppSectionCard(
// // //       title: 'Basic Asset Information',
// // //       compact: true,
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.stretch,
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 flex: 2,
// // //                 child: AppTextField(
// // //                   label: 'Asset Name *',
// // //                   value: state.assetName ?? '',
// // //                   onChanged: (v) => controller.updateField(assetName: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 flex: 3,
// // //                 child: AppTextField(
// // //                   label: 'Description',
// // //                   value: state.description ?? '',
// // //                   onChanged: (v) => controller.updateField(description: v),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 12),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Asset Type *',
// // //                   value: state.assetType,
// // //                   items: _itemsOf(const [
// // //                     'IT Equipment',
// // //                     'Furniture',
// // //                     'Vehicle',
// // //                   ]),
// // //                   onChanged: (v) => controller.updateField(assetType: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Brand *',
// // //                   value: state.brand ?? '',
// // //                   onChanged: (v) => controller.updateField(brand: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Model *',
// // //                   value: state.model ?? '',
// // //                   onChanged: (v) => controller.updateField(model: v),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 12),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Serial No *',
// // //                   value: state.serialNumber ?? '',
// // //                   onChanged: (v) => controller.updateField(serialNumber: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Quantity',
// // //                   value: state.unit,
// // //                   items: _itemsOf(const ['Pcs', 'Set', 'Box', 'Unit']),
// // //                   onChanged: (v) => controller.updateField(unit: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Unit',
// // //                   value: state.unit,
// // //                   items: _itemsOf(const ['Pcs', 'Set', 'Box', 'Unit']),
// // //                   onChanged: (v) => controller.updateField(unit: v),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildTabbedCard(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return Card(
// // //       elevation: 0,
// // //       margin: const EdgeInsets.symmetric(vertical: 8),
// // //       shape: RoundedRectangleBorder(
// // //         borderRadius: BorderRadius.circular(6),
// // //         side: const BorderSide(color: Color(0xFFE5E7EB), width: 0.8),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Container(
// // //             decoration: const BoxDecoration(
// // //               color: Color(0xFFF9FAFB),
// // //               borderRadius: BorderRadius.only(
// // //                 topLeft: Radius.circular(6),
// // //                 topRight: Radius.circular(6),
// // //               ),
// // //               border: Border(
// // //                 bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.8),
// // //               ),
// // //             ),

// // //             child: TabBar(
// // //               controller: _tabController,
// // //               labelColor: const Color(0xFF0B49A5),
// // //               unselectedLabelColor: const Color(0xFF6B7280),
// // //               indicatorColor: const Color(0xFF0B49A5),
// // //               indicatorWeight: 2.0,
// // //               indicatorSize: TabBarIndicatorSize.tab,
// // //               isScrollable: true,
// // //               dividerColor: Colors.transparent,
// // //               padding: EdgeInsets.zero,
// // //               labelPadding: const EdgeInsets.symmetric(horizontal: 16),
// // //               tabAlignment: TabAlignment.start,
// // //               labelStyle: const TextStyle(
// // //                 fontSize: 13,
// // //                 fontWeight: FontWeight.w600,
// // //               ),
// // //               unselectedLabelStyle: const TextStyle(
// // //                 fontSize: 13,
// // //                 fontWeight: FontWeight.w500,
// // //               ),
// // //               tabs: const [
// // //                 Tab(text: 'Classification'),
// // //                 Tab(text: 'Location and Responsibility'),
// // //                 Tab(text: 'Financial Information'),
// // //                 Tab(text: 'Documents / References'),
// // //               ],
// // //             ),
// // //           ),
// // //           SizedBox(
// // //             height: 400,
// // //             child: TabBarView(
// // //               controller: _tabController,
// // //               children: [
// // //                 _buildClassificationTab(state, controller),
// // //                 _buildLocationTab(state, controller),
// // //                 _buildFinancialTab(state, controller),
// // //                 _buildDocumentsTab(state, controller),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildClassificationTab(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return SingleChildScrollView(
// // //       padding: const EdgeInsets.all(12.0),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Asset Class *',
// // //                   value: state.assetClass,
// // //                   items: _itemsOf(const ['Class A', 'Class B', 'Class C']),
// // //                   onChanged: (v) => controller.updateField(assetClass: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Asset Category *',
// // //                   value: state.assetCategory,
// // //                   items: _itemsOf(const [
// // //                     'Laptop',
// // //                     'Desktop',
// // //                     'Printer',
// // //                     'Furniture',
// // //                   ]),
// // //                   onChanged: (v) => controller.updateField(assetCategory: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Sub-Category',
// // //                   value: state.subCategory,
// // //                   items: _itemsOf(const ['Dell', 'HP', 'Lenovo', 'Other']),
// // //                   onChanged: (v) => controller.updateField(subCategory: v),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Depreciation Method',
// // //                   value: state.depreciationMethod,
// // //                   items: _itemsOf(const [
// // //                     'Straight Line',
// // //                     'Declining Balance',
// // //                     'None',
// // //                   ]),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(depreciationMethod: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Useful',
// // //                   value: state.usefulLife?.toString() ?? '',
// // //                   keyboardType: TextInputType.number,
// // //                   onChanged: (v) =>
// // //                       controller.updateField(usefulLife: double.tryParse(v)),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Residual',
// // //                   value: state.residualValue?.toString() ?? '',
// // //                   keyboardType: TextInputType.number,
// // //                   onChanged: (v) =>
// // //                       controller.updateField(residualValue: double.tryParse(v)),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildLocationTab(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return SingleChildScrollView(
// // //       padding: const EdgeInsets.all(12.0),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Company',
// // //                   value: state.company?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(company: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Branch',
// // //                   value: state.branch?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(branch: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Department',
// // //                   value: state.department?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(department: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Location',
// // //                   value: state.location?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(location: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Custodian',
// // //                   value: state.custodian?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(custodian: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFinancialTab(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return SingleChildScrollView(
// // //       padding: const EdgeInsets.all(12.0),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Invoice No',
// // //                   value: state.invoiceNo ?? '',
// // //                   onChanged: (v) => controller.updateField(invoiceNo: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Supplier',
// // //                   value: state.supplier?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(supplier: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDateField(
// // //                   label: 'Acquisition Date',
// // //                   value: state.acquisitionDate,
// // //                   onChanged: (d) => controller.updateField(acquisitionDate: d),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: InkWell(
// // //                   onTap: () => _showAddCostDialog(state, controller),
// // //                   child: InputDecorator(
// // //                     decoration: InputDecoration(
// // //                       labelText: 'Add Cost',
// // //                       border: const OutlineInputBorder(
// // //                         borderSide: BorderSide(
// // //                           color: Color(0xFFD1D5DB),
// // //                           width: 0.8,
// // //                         ),
// // //                       ),
// // //                       enabledBorder: const OutlineInputBorder(
// // //                         borderSide: BorderSide(
// // //                           color: Color(0xFFD1D5DB),
// // //                           width: 0.8,
// // //                         ),
// // //                       ),
// // //                       filled: true,
// // //                       fillColor: Colors.grey.shade100,
// // //                       isDense: true,
// // //                       contentPadding: const EdgeInsets.symmetric(
// // //                         horizontal: 12,
// // //                         vertical: 14,
// // //                       ),
// // //                       suffixIcon: IconButton(
// // //                         icon: const Icon(
// // //                           Icons.add_circle,
// // //                           color: Colors.blue,
// // //                           size: 18,
// // //                         ),
// // //                         tooltip: 'Add Additional Cost',
// // //                         onPressed: () => _showAddCostDialog(state, controller),
// // //                       ),
// // //                     ),
// // //                     child: const SizedBox(
// // //                       height: 20,
// // //                       child: Text(
// // //                         'Click + to add cost',
// // //                         style: TextStyle(color: Colors.grey, fontSize: 13),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           if (state.additionalCosts.isNotEmpty) ...[
// // //             const SizedBox(height: 16),
// // //             _buildAdditionalCostList(state, controller),
// // //           ],
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'GL Asset Account',
// // //                   value: state.glAssetAccount?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) => controller.updateField(
// // //                     glAssetAccount: int.tryParse(v ?? ''),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Accum. Depreciation A/C',
// // //                   value: state.accumDepreciationAccount?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) => controller.updateField(
// // //                     accumDepreciationAccount: int.tryParse(v ?? ''),
// // //                   ),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Depreciation Expense A/C',
// // //                   value: state.depreciationExpenseAccount?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) => controller.updateField(
// // //                     depreciationExpenseAccount: int.tryParse(v ?? ''),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDropdown<String>(
// // //                   label: 'Cost Center',
// // //                   value: state.costCenter?.toString(),
// // //                   items: _itemsOf(const ['1', '2', '3']),
// // //                   onChanged: (v) =>
// // //                       controller.updateField(costCenter: int.tryParse(v ?? '')),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppDateField(
// // //                   label: 'Capitalization Date',
// // //                   value: state.capDate,
// // //                   onChanged: (d) => controller.updateField(capDate: d),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               const Expanded(child: SizedBox()),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDocumentsTab(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return SingleChildScrollView(
// // //       padding: const EdgeInsets.all(12.0),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: _upload(
// // //                   label: 'Invoice Attachment',
// // //                   fileName: state.invoiceAttachmentPath,
// // //                   onTap: () {},
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               Expanded(
// // //                 child: _upload(
// // //                   label: 'PO Attachment',
// // //                   fileName: state.poAttachmentPath,
// // //                   onTap: () {},
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Approval Reference',
// // //                   value: state.approvalReference ?? '',
// // //                   onChanged: (v) =>
// // //                       controller.updateField(approvalReference: v),
// // //                 ),
// // //               ),
// // //               const SizedBox(width: 16),
// // //               const Expanded(child: SizedBox()),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 16),
// // //           Row(
// // //             children: [
// // //               Expanded(
// // //                 child: AppTextField(
// // //                   label: 'Remarks',
// // //                   value: state.remarks ?? '',
// // //                   maxLines: 2,
// // //                   onChanged: (v) => controller.updateField(remarks: v),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Future<void> _showAddCostDialog(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) async {
// // //     final formKey = GlobalKey<FormState>();
// // //     String costType = 'Transportation';
// // //     String currency = 'MMK';
// // //     final purchaseCostCtrl = TextEditingController();
// // //     final otherCostCtrl = TextEditingController();
// // //     final descCtrl = TextEditingController();
// // //     DateTime? costDate = DateTime.now();

// // //     await showDialog(
// // //       context: context,
// // //       builder: (ctx) => StatefulBuilder(
// // //         builder: (ctx, setDialogState) {
// // //           final p = double.tryParse(purchaseCostCtrl.text) ?? 0.0;
// // //           final o = double.tryParse(otherCostCtrl.text) ?? 0.0;
// // //           final totalCost = p + o;

// // //           return AlertDialog(
// // //             title: const Text('Add Additional Cost'),
// // //             content: SizedBox(
// // //               width: 500,
// // //               child: Form(
// // //                 key: formKey,
// // //                 child: SingleChildScrollView(
// // //                   child: Column(
// // //                     mainAxisSize: MainAxisSize.min,
// // //                     children: [
// // //                       AppDropdown<String>(
// // //                         label: 'Cost Type *',
// // //                         value: costType,
// // //                         items: _itemsOf(const [
// // //                           'Transportation',
// // //                           'Installation',
// // //                           'Tax',
// // //                           'Insurance',
// // //                           'Other',
// // //                         ]),
// // //                         onChanged: (v) =>
// // //                             setDialogState(() => costType = v ?? 'Other'),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       TextFormField(
// // //                         controller: purchaseCostCtrl,
// // //                         keyboardType: TextInputType.number,
// // //                         decoration: const InputDecoration(
// // //                           labelText: 'Purchase Cost',
// // //                           isDense: true,
// // //                           prefixIcon: Icon(Icons.attach_money),
// // //                         ),
// // //                         onChanged: (_) => setDialogState(() {}),
// // //                         validator: (v) {
// // //                           if (v == null || v.isEmpty) return null;
// // //                           if (double.tryParse(v) == null) {
// // //                             return 'Invalid number';
// // //                           }
// // //                           return null;
// // //                         },
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       TextFormField(
// // //                         controller: otherCostCtrl,
// // //                         keyboardType: TextInputType.number,
// // //                         decoration: const InputDecoration(
// // //                           labelText: 'Other Capitalizable Cost',
// // //                           isDense: true,
// // //                           prefixIcon: Icon(Icons.add),
// // //                         ),
// // //                         onChanged: (_) => setDialogState(() {}),
// // //                         validator: (v) {
// // //                           if (v == null || v.isEmpty) return null;
// // //                           if (double.tryParse(v) == null) {
// // //                             return 'Invalid number';
// // //                           }
// // //                           return null;
// // //                         },
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       Container(
// // //                         padding: const EdgeInsets.symmetric(
// // //                           horizontal: 16,
// // //                           vertical: 16,
// // //                         ),
// // //                         decoration: BoxDecoration(
// // //                           color: Colors.blue.shade50,
// // //                           border: Border.all(
// // //                             color: Colors.blue.shade300,
// // //                             width: 0.8,
// // //                           ),
// // //                           borderRadius: BorderRadius.circular(4),
// // //                         ),
// // //                         child: Row(
// // //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                           children: [
// // //                             const Row(
// // //                               children: [
// // //                                 Icon(Icons.calculate, color: Colors.blue),
// // //                                 SizedBox(width: 8),
// // //                                 Text(
// // //                                   'Total Capitalizable Cost',
// // //                                   style: TextStyle(
// // //                                     fontSize: 13,
// // //                                     color: Colors.blueGrey,
// // //                                     fontWeight: FontWeight.w600,
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                             Text(
// // //                               totalCost.toStringAsFixed(2),
// // //                               style: const TextStyle(
// // //                                 fontSize: 18,
// // //                                 fontWeight: FontWeight.bold,
// // //                                 color: Colors.blue,
// // //                               ),
// // //                             ),
// // //                           ],
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       AppDropdown<String>(
// // //                         label: 'Currency',
// // //                         value: currency,
// // //                         items: _itemsOf(const ['MMK', 'USD', 'THB']),
// // //                         onChanged: (v) =>
// // //                             setDialogState(() => currency = v ?? 'MMK'),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       InkWell(
// // //                         onTap: () async {
// // //                           final d = await showDatePicker(
// // //                             context: ctx,
// // //                             initialDate: costDate ?? DateTime.now(),
// // //                             firstDate: DateTime(2000),
// // //                             lastDate: DateTime(2100),
// // //                           );
// // //                           if (d != null) {
// // //                             setDialogState(() => costDate = d);
// // //                           }
// // //                         },
// // //                         child: InputDecorator(
// // //                           decoration: const InputDecoration(
// // //                             labelText: 'Cost Date',
// // //                             isDense: true,
// // //                             suffixIcon: Icon(Icons.calendar_today, size: 18),
// // //                           ),
// // //                           child: Text(
// // //                             costDate == null ? '' : _fmtDate(costDate),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                       const SizedBox(height: 12),
// // //                       TextFormField(
// // //                         controller: descCtrl,
// // //                         maxLines: 2,
// // //                         decoration: const InputDecoration(
// // //                           labelText: 'Description',
// // //                           isDense: true,
// // //                         ),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () => Navigator.pop(ctx),
// // //                 child: const Text('Cancel'),
// // //               ),
// // //               ElevatedButton(
// // //                 onPressed: () {
// // //                   if (formKey.currentState!.validate()) {
// // //                     if (totalCost <= 0) {
// // //                       ScaffoldMessenger.of(ctx).showSnackBar(
// // //                         const SnackBar(
// // //                           content: Text('Total must be greater than zero'),
// // //                         ),
// // //                       );
// // //                       return;
// // //                     }
// // //                     controller.addAdditionalCostItem(
// // //                       AdditionalCostItem(
// // //                         costType: costType,
// // //                         purchaseCost: p,
// // //                         otherCapitalizableCost: o,
// // //                         currency: currency,
// // //                         description: descCtrl.text,
// // //                         date: costDate,
// // //                       ),
// // //                     );
// // //                     Navigator.pop(ctx);
// // //                   }
// // //                 },
// // //                 child: const Text('Add'),
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildAdditionalCostList(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     final total = state.additionalCosts.fold<double>(0, (s, e) => s + e.amount);

// // //     return Container(
// // //       padding: const EdgeInsets.all(12),
// // //       decoration: BoxDecoration(
// // //         color: Colors.blue.shade50,
// // //         border: Border.all(color: Colors.blue.shade200, width: 0.8),
// // //         borderRadius: BorderRadius.circular(6),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: [
// // //               const Text(
// // //                 'Additional Costs',
// // //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// // //               ),
// // //               Text(
// // //                 'Grand Total: ${total.toStringAsFixed(2)}',
// // //                 style: const TextStyle(
// // //                   fontWeight: FontWeight.bold,
// // //                   color: Colors.blue,
// // //                   fontSize: 14,
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const Divider(height: 16, thickness: 0.8),
// // //           ...state.additionalCosts.asMap().entries.map((entry) {
// // //             final i = entry.key;
// // //             final c = entry.value;
// // //             return Padding(
// // //               padding: const EdgeInsets.symmetric(vertical: 6),
// // //               child: Row(
// // //                 children: [
// // //                   Expanded(flex: 2, child: Text(c.costType)),
// // //                   Expanded(
// // //                     flex: 2,
// // //                     child: Text(c.purchaseCost.toStringAsFixed(2)),
// // //                   ),
// // //                   Expanded(
// // //                     flex: 2,
// // //                     child: Text(c.otherCapitalizableCost.toStringAsFixed(2)),
// // //                   ),
// // //                   Expanded(
// // //                     flex: 2,
// // //                     child: Text(
// // //                       c.amount.toStringAsFixed(2),
// // //                       style: const TextStyle(
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.blue,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   Expanded(flex: 2, child: Text(c.currency)),
// // //                   Expanded(
// // //                     flex: 2,
// // //                     child: Text(c.date == null ? '-' : _fmtDate(c.date)),
// // //                   ),
// // //                   SizedBox(
// // //                     width: 40,
// // //                     child: IconButton(
// // //                       icon: const Icon(
// // //                         Icons.delete,
// // //                         color: Colors.red,
// // //                         size: 20,
// // //                       ),
// // //                       onPressed: () => controller.removeAdditionalCostItem(i),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             );
// // //           }),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildValidationPanel(FarAssetFormState state) {
// // //     final isError = state.validationStatus == 'Error';
// // //     final color = isError ? Colors.red : Colors.orange;

// // //     return Container(
// // //       padding: const EdgeInsets.all(16),
// // //       decoration: BoxDecoration(
// // //         color: color.withOpacity(0.08),
// // //         border: Border.all(color: color, width: 0.8),
// // //         borderRadius: BorderRadius.circular(6),
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             children: [
// // //               Icon(Icons.info_outline, color: color, size: 20),
// // //               const SizedBox(width: 8),
// // //               Text(
// // //                 'Validation Status: ${state.validationStatus}',
// // //                 style: TextStyle(fontWeight: FontWeight.bold, color: color),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 8),
// // //           ...state.validationMessages.map(
// // //             (m) => Padding(
// // //               padding: const EdgeInsets.only(left: 32, top: 4),
// // //               child: Text('- $m'),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildActionBar(
// // //     FarAssetFormState state,
// // //     FarAssetFormController controller,
// // //   ) {
// // //     return FixedBottomActionBar(
// // //       isLoading: state.saving,
// // //       cancelButton: OutlinedButton(
// // //         onPressed: () => Navigator.pop(context),
// // //         child: const Text('Cancel'),
// // //       ),
// // //       actions: [
// // //         OutlinedButton(
// // //           onPressed: controller.validateForm,
// // //           child: const Text('Validate'),
// // //         ),
// // //         ElevatedButton(
// // //           style: ElevatedButton.styleFrom(
// // //             backgroundColor: Colors.grey[200],
// // //             foregroundColor: Colors.black87,
// // //             elevation: 0,
// // //           ),
// // //           onPressed: state.saving
// // //               ? null
// // //               : () async {
// // //                   await controller.saveDraft();
// // //                   if (mounted) Navigator.pop(context);
// // //                 },
// // //           child: const Text('Save & New'),
// // //         ),
// // //       ],
// // //       saveButton: ElevatedButton(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: const Color(0xFF0B49A5),
// // //           foregroundColor: Colors.white,
// // //           elevation: 0,
// // //         ),
// // //         onPressed: state.saving
// // //             ? null
// // //             : () async {
// // //                 await controller.save();
// // //                 if (mounted) Navigator.pop(context);
// // //               },
// // //         child: state.saving
// // //             ? const SizedBox(
// // //                 width: 16,
// // //                 height: 16,
// // //                 child: CircularProgressIndicator(
// // //                   strokeWidth: 2,
// // //                   color: Colors.white,
// // //                 ),
// // //               )
// // //             : const Text('Save'),
// // //       ),
// // //     );
// // //   }

// // //   Widget _upload({
// // //     required String label,
// // //     required String? fileName,
// // //     required VoidCallback onTap,
// // //   }) {
// // //     return InkWell(
// // //       onTap: onTap,
// // //       child: InputDecorator(
// // //         decoration: InputDecoration(
// // //           labelText: label,
// // //           isDense: true,
// // //           suffixIcon: const Icon(Icons.upload_file, size: 18),
// // //         ),
// // //         child: Text(
// // //           fileName ?? 'Upload File',
// // //           style: TextStyle(
// // //             color: fileName == null ? Colors.grey : Colors.black87,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   List<AppDropdownItem<String>> _itemsOf(List<String> values) {
// // //     return [
// // //       for (final v in values) AppDropdownItem<String>(value: v, label: v),
// // //     ];
// // //   }

// // //   String _fmtDate(DateTime? d) {
// // //     if (d == null) return '';
// // //     return '${d.day.toString().padLeft(2, '0')}/'
// // //         '${d.month.toString().padLeft(2, '0')}/'
// // //         '${d.year}';
// // //   }

// // //   String _fmtDateTime(DateTime? d) {
// // //     if (d == null) return '';
// // //     return '${d.day.toString().padLeft(2, '0')}/'
// // //         '${d.month.toString().padLeft(2, '0')}/'
// // //         '${d.year} '
// // //         '${d.hour.toString().padLeft(2, '0')}:'
// // //         '${d.minute.toString().padLeft(2, '0')}';
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:go_router/go_router.dart';

// // import '../../../../../core/footer/bs_footer_message_provider.dart';
// // import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

// // import '../../../../../shared/buttons/bs_action_button.dart';
// // import '../../../../../shared/buttons/bs_cancel_button.dart';
// // import '../../../../../shared/buttons/bs_new_button.dart';
// // import '../../../../../shared/buttons/bs_save_button.dart';

// // import '../../../../../shared/inputs/bs_dropdown_field.dart';
// // import '../../../../../shared/inputs/bs_text_field.dart';
// // import '../../../../../shared/inputs/bs_date_field.dart';

// // import '../../../../../shared/layout/bs_detail_area.dart';
// // import '../../../../../shared/layout/bs_form_action_bar.dart';
// // import '../../../../../shared/layout/bs_form_row.dart';
// // import '../../../../../shared/layout/bs_master_entry_page.dart';

// // import '../../../../../shared/navigation/bs_breadcrumb.dart';
// // import '../../../../../shared/navigation/bs_breadcrumb_item.dart';

// // import '../controller/far_asset_form_controller.dart';
// // import '../controller/far_asset_dropdown_provider.dart';

// // class FarAssetFormPage extends ConsumerStatefulWidget {
// //   const FarAssetFormPage({super.key, this.assetId});
// //   final int? assetId;

// //   @override
// //   ConsumerState<FarAssetFormPage> createState() => _FarAssetFormPageState();
// // }

// // class _FarAssetFormPageState extends ConsumerState<FarAssetFormPage> {
// //   final _formKey = GlobalKey<FormState>();

// //   // Controllers
// //   final _assetNameController = TextEditingController();
// //   final _descriptionController = TextEditingController();
// //   final _brandController = TextEditingController();
// //   final _modelController = TextEditingController();
// //   final _serialNumberController = TextEditingController();
// //   final _quantityController = TextEditingController();
// //   final _usefulLifeController = TextEditingController();
// //   final _residualValueController = TextEditingController();
// //   final _invoiceNoController = TextEditingController();
// //   final _purchaseCostController = TextEditingController();
// //   final _otherCapitalizableCostController = TextEditingController();
// //   final _approvalReferenceController = TextEditingController();
// //   final _remarksController = TextEditingController();

// //   int _loadedVersion = -1;

// //   static const List<String> _assetTypeOptions = [
// //     'IT Equipment',
// //     'Furniture',
// //     'Vehicle',
// //   ];
// //   static const List<String> _unitOptions = ['Pcs', 'Set', 'Box', 'Unit'];
// //   static const List<String> _assetClassOptions = [
// //     'Class A',
// //     'Class B',
// //     'Class C',
// //   ];
// //   static const List<String> _assetCategoryOptions = [
// //     'Laptop',
// //     'Desktop',
// //     'Printer',
// //     'Furniture',
// //   ];
// //   static const List<String> _subCategoryOptions = [
// //     'Dell',
// //     'HP',
// //     'Lenovo',
// //     'Other',
// //   ];
// //   static const List<String> _depreciationMethodOptions = [
// //     'Straight Line',
// //     'Declining Balance',
// //     'None',
// //   ];
// //   static const List<String> _currencyOptions = ['MMK', 'USD', 'THB'];
// //   static const List<String> _accountOptions = ['1', '2', '3'];

// //   @override
// //   void dispose() {
// //     _assetNameController.dispose();
// //     _descriptionController.dispose();
// //     _brandController.dispose();
// //     _modelController.dispose();
// //     _serialNumberController.dispose();
// //     _quantityController.dispose();
// //     _usefulLifeController.dispose();
// //     _residualValueController.dispose();
// //     _invoiceNoController.dispose();
// //     _purchaseCostController.dispose();
// //     _otherCapitalizableCostController.dispose();
// //     _approvalReferenceController.dispose();
// //     _remarksController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = farAssetFormControllerProvider(widget.assetId);
// //     final state = ref.watch(provider);
// //     final notifier = ref.read(provider.notifier);
// //     final isNew = widget.assetId == null;

// //     final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);
// //     final legalEntityName = currentLegalEntity?.legalEntityName ?? '';

// //     final organizationsAsync = ref.watch(organizationsProvider);
// //     final partnersAsync = ref.watch(partnersProvider);

// //     if (_loadedVersion != state.loadVersion) {
// //       _loadedVersion = state.loadVersion;
// //       _assetNameController.text = state.assetName;
// //       _descriptionController.text = state.description ?? '';
// //       _brandController.text = state.brand ?? '';
// //       _modelController.text = state.model ?? '';
// //       _serialNumberController.text = state.serialNumber ?? '';
// //       _quantityController.text = state.quantity?.toString() ?? '';
// //       _usefulLifeController.text = state.usefulLife?.toString() ?? '';
// //       _residualValueController.text = state.residualValue?.toString() ?? '';
// //       _invoiceNoController.text = state.invoiceNo ?? '';
// //       _purchaseCostController.text = state.purchaseCost?.toString() ?? '';
// //       _otherCapitalizableCostController.text =
// //           state.otherCapitalizableCost?.toString() ?? '';
// //       _approvalReferenceController.text = state.approvalReference ?? '';
// //       _remarksController.text = state.remarks ?? '';
// //     }

// //     final enabled = !state.loading && !state.saving;

// //     return Form(
// //       key: _formKey,
// //       child: BsMasterEntryPage(
// //         // ═══════════════════════════════════════════════════════════
// //         // HEADER — Status ကို Metadata Row ထဲ ထည့်ထားသည်
// //         // ═══════════════════════════════════════════════════════════
// //         routeMeta: BsMasterEntryRouteMeta(
// //           title: 'Fixed Asset Entry',
// //           subtitle: isNew
// //               ? 'Create fixed asset profile'
// //               : 'Edit fixed asset profile',
// //           moduleCode: 'FAR',
// //           screenCode: 'FAR_ASSET',
// //           recordId: widget.assetId?.toString(),
// //           breadcrumb: BsBreadcrumb(
// //             items: [
// //               const BsBreadcrumbItem(label: 'Home', routePath: '/'),
// //               const BsBreadcrumbItem(label: 'Fixed Assets Register'),
// //               const BsBreadcrumbItem(
// //                 label: 'Core Entity Entry',
// //                 routePath: '/far/assets',
// //               ),
// //               BsBreadcrumbItem(label: isNew ? 'New' : 'Edit'),
// //             ],
// //           ),
// //           // ─── Metadata Row (Status ပါ ဒီထဲမှာ) ───
// //           draftNo: 'DRAFT-000001',
// //           source: 'Manual',
// //           draftDate: '09/10/2026',
// //           preparedBy: 'User Name',
// //           lastUpdated: '09/10/2026 14:54',
// //           status: 'Draft',
// //         ),

// //         // Page actions
// //         pageActions: [
// //           BsActionButton(
// //             label: 'Check Duplicate',
// //             icon: Icons.manage_search,
// //             onPressed: enabled ? _checkDuplicate : null,
// //           ),
// //           if (!isNew)
// //             BsNewButton(
// //               onPressed: state.saving
// //                   ? null
// //                   : () => _openNew(context, state.isDirty),
// //             ),
// //         ],

// //         // Basic Info — 4 rows flat
// //         basicInfo: _buildBasicInfoSection(
// //           state: state,
// //           notifier: notifier,
// //           legalEntityName: legalEntityName,
// //           enabled: enabled,
// //         ),
// //         basicInfoTitle: 'Basic Asset Information',
// //         basicInfoStatus: state.status,

// //         // Tabs — 4 tabs
// //         detailContent: BsTabbedDetailArea(
// //           tabs: [
// //             BsDetailTab(
// //               title: 'Classification',
// //               icon: Icons.category_outlined,
// //               child: _ClassificationTab(
// //                 state: state,
// //                 notifier: notifier,
// //                 usefulLifeController: _usefulLifeController,
// //                 residualValueController: _residualValueController,
// //                 assetClassOptions: _assetClassOptions,
// //                 assetCategoryOptions: _assetCategoryOptions,
// //                 subCategoryOptions: _subCategoryOptions,
// //                 depreciationMethodOptions: _depreciationMethodOptions,
// //               ),
// //             ),
// //             BsDetailTab(
// //               title: 'Location and Responsibility',
// //               icon: Icons.location_on_outlined,
// //               child: _LocationTab(
// //                 state: state,
// //                 notifier: notifier,
// //                 organizationsAsync: organizationsAsync,
// //                 partnersAsync: partnersAsync,
// //               ),
// //             ),
// //             BsDetailTab(
// //               title: 'Financial Information',
// //               icon: Icons.attach_money_outlined,
// //               child: _FinancialTab(
// //                 state: state,
// //                 notifier: notifier,
// //                 partnersAsync: partnersAsync,
// //                 invoiceNoController: _invoiceNoController,
// //                 purchaseCostController: _purchaseCostController,
// //                 otherCostController: _otherCapitalizableCostController,
// //                 currencyOptions: _currencyOptions,
// //                 accountOptions: _accountOptions,
// //               ),
// //             ),
// //             BsDetailTab(
// //               title: 'Documents / References',
// //               icon: Icons.attach_file_outlined,
// //               child: _DocumentsTab(
// //                 state: state,
// //                 notifier: notifier,
// //                 approvalReferenceController: _approvalReferenceController,
// //                 remarksController: _remarksController,
// //               ),
// //             ),
// //           ],
// //         ),

// //         // Action bar
// //         formActions: BsFormActionBar(
// //           isLoading: state.saving,
// //           cancelButton: BsCancelButton(
// //             onPressed: () => _cancel(context, state.isDirty),
// //           ),
// //           actions: [
// //             BsActionButton(
// //               label: 'Save Draft',
// //               icon: Icons.mail_outline,
// //               onPressed: state.saving
// //                   ? null
// //                   : () => _saveDraft(context, notifier),
// //             ),
// //           ],
// //           saveButton: BsSaveButton(
// //             onPressed: state.saving ? null : () => _save(context, notifier),
// //           ),
// //         ),

// //         isLoading: state.loading || state.saving,
// //         isDirty: state.isDirty,
// //         onSaveShortcut: state.saving ? null : () => _save(context, notifier),
// //         onCancelShortcut: () => _cancel(context, state.isDirty),
// //       ),
// //     );
// //   }

// //   // ═══════════════════════════════════════════════════════════
// //   // BASIC INFO — 4 flat rows
// //   // ═══════════════════════════════════════════════════════════
// //   Widget _buildBasicInfoSection({
// //     required FarAssetFormState state,
// //     required FarAssetFormController notifier,
// //     required String legalEntityName,
// //     required bool enabled,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.stretch,
// //       children: [
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 2,
// //           children: [
// //             BsTextField(
// //               label: 'Legal Entity',
// //               controller: TextEditingController(text: legalEntityName),
// //               enabled: false,
// //             ),
// //             BsTextField(
// //               label: 'Asset Name',
// //               controller: _assetNameController,
// //               requiredField: true,
// //               enabled: enabled,
// //               onChanged: notifier.updateAssetName,
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 2,
// //           children: [
// //             BsTextField(
// //               label: 'Description',
// //               controller: _descriptionController,
// //               enabled: enabled,
// //               onChanged: notifier.updateDescription,
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Asset Type',
// //               value: state.assetType,
// //               requiredField: true,
// //               items: _assetTypeOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: notifier.updateAssetType,
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             BsTextField(
// //               label: 'Brand',
// //               controller: _brandController,
// //               requiredField: true,
// //               enabled: enabled,
// //               onChanged: notifier.updateBrand,
// //             ),
// //             BsTextField(
// //               label: 'Model',
// //               controller: _modelController,
// //               requiredField: true,
// //               enabled: enabled,
// //               onChanged: notifier.updateModel,
// //             ),
// //             BsTextField(
// //               label: 'Serial No',
// //               controller: _serialNumberController,
// //               requiredField: true,
// //               enabled: enabled,
// //               onChanged: notifier.updateSerialNumber,
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 2,
// //           children: [
// //             BsTextField(
// //               label: 'Quantity',
// //               controller: _quantityController,
// //               keyboardType: TextInputType.number,
// //               enabled: enabled,
// //               onChanged: (v) =>
// //                   notifier.updateField(quantity: double.tryParse(v)),
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Unit',
// //               value: state.unit,
// //               items: _unitOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: (v) => notifier.updateField(unit: v),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   void _checkDuplicate() {
// //     final name = _assetNameController.text.trim();
// //     if (name.isEmpty) {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showValidation('Enter Asset Name before checking duplicate.');
// //       return;
// //     }
// //     ref
// //         .read(bsFooterMessageProvider.notifier)
// //         .showInfo('Duplicate check is ready for backend integration.');
// //   }

// //   Future<void> _save(
// //     BuildContext context,
// //     FarAssetFormController notifier,
// //   ) async {
// //     if (!(_formKey.currentState?.validate() ?? false)) {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showValidation('Please correct the highlighted fields.');
// //       return;
// //     }
// //     await notifier.save();
// //     if (!context.mounted) return;
// //     if (notifier.state.error == null) {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showSuccess('Asset saved successfully.');
// //       context.go('/far/assets');
// //     } else {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showError('Save failed. Please try again.');
// //     }
// //   }

// //   Future<void> _saveDraft(
// //     BuildContext context,
// //     FarAssetFormController notifier,
// //   ) async {
// //     if (!(_formKey.currentState?.validate() ?? false)) {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showValidation('Please correct the highlighted fields.');
// //       return;
// //     }
// //     await notifier.saveDraft();
// //     if (!context.mounted) return;
// //     if (notifier.state.error == null) {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showSuccess('Asset draft saved successfully.');
// //       context.go('/far/assets');
// //     } else {
// //       ref
// //           .read(bsFooterMessageProvider.notifier)
// //           .showError('Save failed. Please try again.');
// //     }
// //   }

// //   Future<void> _openNew(BuildContext context, bool isDirty) async {
// //     final canLeave = await BsFormDirtyGuard.confirmDiscard(
// //       context,
// //       isDirty: isDirty,
// //     );
// //     if (canLeave && context.mounted) context.go('/far/assets/new');
// //   }

// //   Future<void> _cancel(BuildContext context, bool isDirty) async {
// //     final canLeave = await BsFormDirtyGuard.confirmDiscard(
// //       context,
// //       isDirty: isDirty,
// //     );
// //     if (canLeave && context.mounted) context.go('/far/assets');
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // // TAB 1 — CLASSIFICATION
// // // ═══════════════════════════════════════════════════════════════
// // class _ClassificationTab extends StatelessWidget {
// //   const _ClassificationTab({
// //     required this.state,
// //     required this.notifier,
// //     required this.usefulLifeController,
// //     required this.residualValueController,
// //     required this.assetClassOptions,
// //     required this.assetCategoryOptions,
// //     required this.subCategoryOptions,
// //     required this.depreciationMethodOptions,
// //   });

// //   final FarAssetFormState state;
// //   final FarAssetFormController notifier;
// //   final TextEditingController usefulLifeController;
// //   final TextEditingController residualValueController;
// //   final List<String> assetClassOptions;
// //   final List<String> assetCategoryOptions;
// //   final List<String> subCategoryOptions;
// //   final List<String> depreciationMethodOptions;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             BsDropdownField<String>(
// //               label: 'Asset Class',
// //               value: state.assetClass,
// //               requiredField: true,
// //               items: assetClassOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: notifier.updateAssetClass,
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Asset Category',
// //               value: state.assetCategory,
// //               requiredField: true,
// //               items: assetCategoryOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: notifier.updateAssetCategory,
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Sub-Category',
// //               value: state.subCategory,
// //               items: subCategoryOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: notifier.updateSubCategory,
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             BsDropdownField<String>(
// //               label: 'Depreciation Method',
// //               value: state.depreciationMethod,
// //               items: depreciationMethodOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: notifier.updateDepreciationMethod,
// //             ),
// //             BsTextField(
// //               label: 'Useful Life',
// //               keyboardType: TextInputType.number,
// //               controller: usefulLifeController,
// //               onChanged: (v) => notifier.updateUsefulLife(double.tryParse(v)),
// //             ),
// //             BsTextField(
// //               label: 'Residual Value',
// //               keyboardType: TextInputType.number,
// //               controller: residualValueController,
// //               onChanged: (v) =>
// //                   notifier.updateResidualValue(double.tryParse(v)),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // // TAB 2 — LOCATION
// // // ═══════════════════════════════════════════════════════════════
// // class _LocationTab extends StatelessWidget {
// //   const _LocationTab({
// //     required this.state,
// //     required this.notifier,
// //     required this.organizationsAsync,
// //     required this.partnersAsync,
// //   });

// //   final FarAssetFormState state;
// //   final FarAssetFormController notifier;
// //   final AsyncValue<List<Map<String, dynamic>>> organizationsAsync;
// //   final AsyncValue<List<Map<String, dynamic>>> partnersAsync;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             _AsyncBackendDropdown(
// //               async: organizationsAsync,
// //               label: 'Company',
// //               value: state.company,
// //               onChanged: notifier.updateCompany,
// //             ),
// //             _AsyncBackendDropdown(
// //               async: organizationsAsync,
// //               label: 'Branch',
// //               value: state.branch,
// //               onChanged: notifier.updateBranch,
// //             ),
// //             _AsyncBackendDropdown(
// //               async: organizationsAsync,
// //               label: 'Department',
// //               value: state.department,
// //               onChanged: notifier.updateDepartment,
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 2,
// //           children: [
// //             _AsyncBackendDropdown(
// //               async: organizationsAsync,
// //               label: 'Location',
// //               value: state.location,
// //               onChanged: notifier.updateLocation,
// //             ),
// //             _AsyncBackendDropdown(
// //               async: partnersAsync,
// //               label: 'Custodian',
// //               value: state.custodian,
// //               onChanged: notifier.updateCustodian,
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // // TAB 3 — FINANCIAL
// // // ═══════════════════════════════════════════════════════════════
// // class _FinancialTab extends StatelessWidget {
// //   const _FinancialTab({
// //     required this.state,
// //     required this.notifier,
// //     required this.partnersAsync,
// //     required this.invoiceNoController,
// //     required this.purchaseCostController,
// //     required this.otherCostController,
// //     required this.currencyOptions,
// //     required this.accountOptions,
// //   });

// //   final FarAssetFormState state;
// //   final FarAssetFormController notifier;
// //   final AsyncValue<List<Map<String, dynamic>>> partnersAsync;
// //   final TextEditingController invoiceNoController;
// //   final TextEditingController purchaseCostController;
// //   final TextEditingController otherCostController;
// //   final List<String> currencyOptions;
// //   final List<String> accountOptions;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             BsTextField(
// //               label: 'Invoice No',
// //               controller: invoiceNoController,
// //               onChanged: notifier.updateInvoiceNo,
// //             ),
// //             _AsyncBackendDropdown(
// //               async: partnersAsync,
// //               label: 'Supplier',
// //               value: state.supplier,
// //               onChanged: notifier.updateSupplier,
// //             ),
// //             BsDateField(
// //               label: 'Acquisition Date',
// //               controller: TextEditingController(
// //                 text: state.acquisitionDate == null
// //                     ? ''
// //                     : _fmt(state.acquisitionDate!),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             BsTextField(
// //               label: 'Purchase Cost',
// //               controller: purchaseCostController,
// //               keyboardType: TextInputType.number,
// //               onChanged: (v) =>
// //                   notifier.updateField(purchaseCost: double.tryParse(v)),
// //             ),
// //             BsTextField(
// //               label: 'Other Capitalizable Cost',
// //               controller: otherCostController,
// //               keyboardType: TextInputType.number,
// //               onChanged: (v) => notifier.updateField(
// //                 otherCapitalizableCost: double.tryParse(v),
// //               ),
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Currency',
// //               value: state.currency,
// //               items: currencyOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: (v) => notifier.updateField(currency: v),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 3,
// //           children: [
// //             BsDropdownField<String>(
// //               label: 'GL Asset Account',
// //               value: state.glAssetAccount?.toString(),
// //               items: accountOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: (v) =>
// //                   notifier.updateGlAssetAccount(int.tryParse(v ?? '')),
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Accum. Depreciation A/C',
// //               value: state.accumDepreciationAccount?.toString(),
// //               items: accountOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: (v) => notifier.updateAccumDepreciationAccount(
// //                 int.tryParse(v ?? ''),
// //               ),
// //             ),
// //             BsDropdownField<String>(
// //               label: 'Depreciation Expense A/C',
// //               value: state.depreciationExpenseAccount?.toString(),
// //               items: accountOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: (v) => notifier.updateDepreciationExpenseAccount(
// //                 int.tryParse(v ?? ''),
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 2,
// //           children: [
// //             BsDropdownField<String>(
// //               label: 'Cost Center',
// //               value: state.costCenter?.toString(),
// //               items: accountOptions
// //                   .map(
// //                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
// //                   )
// //                   .toList(),
// //               onChanged: (v) =>
// //                   notifier.updateCostCenter(int.tryParse(v ?? '')),
// //             ),
// //             BsDateField(
// //               label: 'Capitalization Date',
// //               controller: TextEditingController(
// //                 text: state.capDate == null ? '' : _fmt(state.capDate!),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }

// //   static String _fmt(DateTime d) {
// //     final m = d.month.toString().padLeft(2, '0');
// //     final day = d.day.toString().padLeft(2, '0');
// //     return '${d.year}-$m-$day';
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // // TAB 4 — DOCUMENTS
// // // ═══════════════════════════════════════════════════════════════
// // class _DocumentsTab extends StatelessWidget {
// //   const _DocumentsTab({
// //     required this.state,
// //     required this.notifier,
// //     required this.approvalReferenceController,
// //     required this.remarksController,
// //   });

// //   final FarAssetFormState state;
// //   final FarAssetFormController notifier;
// //   final TextEditingController approvalReferenceController;
// //   final TextEditingController remarksController;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 2,
// //           children: [
// //             BsTextField(
// //               label: 'Approval Reference',
// //               controller: approvalReferenceController,
// //               onChanged: notifier.updateApprovalReference,
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 12),
// //         BsFormRow(
// //           fieldWidth: 260,
// //           maxColumns: 1,
// //           children: [
// //             BsTextField(
// //               label: 'Remarks',
// //               controller: remarksController,
// //               onChanged: notifier.updateRemarks,
// //             ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// // // ═══════════════════════════════════════════════════════════════
// // // ASYNC BACKEND DROPDOWN HELPER
// // // ═══════════════════════════════════════════════════════════════
// // class _AsyncBackendDropdown extends StatelessWidget {
// //   const _AsyncBackendDropdown({
// //     required this.async,
// //     required this.label,
// //     required this.value,
// //     required this.onChanged,
// //   });

// //   final AsyncValue<List<Map<String, dynamic>>> async;
// //   final String label;
// //   final int? value;
// //   final ValueChanged<int?> onChanged;

// //   @override
// //   Widget build(BuildContext context) {
// //     return async.when(
// //       loading: () => BsTextField(
// //         label: label,
// //         controller: TextEditingController(text: 'Loading...'),
// //         enabled: false,
// //       ),
// //       error: (e, _) => BsTextField(
// //         label: label,
// //         controller: TextEditingController(text: 'Error'),
// //         enabled: false,
// //       ),
// //       data: (items) {
// //         final mapped = items
// //             .map((item) {
// //               final id = int.tryParse(item['id']?.toString() ?? '');
// //               final name =
// //                   item['name']?.toString() ??
// //                   item['legal_entity_name']?.toString() ??
// //                   item['partner_name']?.toString() ??
// //                   item['display_name']?.toString() ??
// //                   item['title']?.toString() ??
// //                   'ID ${item['id']}';
// //               return DropdownMenuItem<int>(
// //                 value: id,
// //                 child: Text(name, overflow: TextOverflow.ellipsis),
// //               );
// //             })
// //             .where((item) => item.value != null)
// //             .toList();

// //         final selectedExists = mapped.any((item) => item.value == value);

// //         return BsDropdownField<int>(
// //           label: label,
// //           value: selectedExists ? value : null,
// //           items: mapped,
// //           onChanged: onChanged,
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../../core/footer/bs_footer_message_provider.dart';
// import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

// import '../../../../../shared/buttons/bs_action_button.dart';
// import '../../../../../shared/buttons/bs_cancel_button.dart';
// import '../../../../../shared/buttons/bs_new_button.dart';
// import '../../../../../shared/buttons/bs_save_button.dart';

// import '../../../../../shared/inputs/bs_dropdown_field.dart';
// import '../../../../../shared/inputs/bs_text_field.dart';
// import '../../../../../shared/inputs/bs_date_field.dart';

// import '../../../../../shared/layout/bs_detail_area.dart';
// import '../../../../../shared/layout/bs_form_action_bar.dart';
// import '../../../../../shared/layout/bs_form_row.dart';
// import '../../../../../shared/layout/bs_master_entry_page.dart';

// import '../../../../../shared/navigation/bs_breadcrumb.dart';
// import '../../../../../shared/navigation/bs_breadcrumb_item.dart';

// import '../controller/far_asset_form_controller.dart';
// import '../controller/far_asset_dropdown_provider.dart';

// class FarAssetFormPage extends ConsumerStatefulWidget {
//   const FarAssetFormPage({super.key, this.assetId});
//   final int? assetId;

//   @override
//   ConsumerState<FarAssetFormPage> createState() => _FarAssetFormPageState();
// }

// class _FarAssetFormPageState extends ConsumerState<FarAssetFormPage> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final _assetNameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _brandController = TextEditingController();
//   final _modelController = TextEditingController();
//   final _serialNumberController = TextEditingController();
//   final _quantityController = TextEditingController();
//   final _usefulLifeController = TextEditingController();
//   final _residualValueController = TextEditingController();
//   final _invoiceNoController = TextEditingController();
//   final _purchaseCostController = TextEditingController();
//   final _otherCapitalizableCostController = TextEditingController();
//   final _approvalReferenceController = TextEditingController();
//   final _remarksController = TextEditingController();

//   int _loadedVersion = -1;

//   static const List<String> _assetTypeOptions = [
//     'IT Equipment',
//     'Furniture',
//     'Vehicle',
//   ];
//   static const List<String> _unitOptions = ['Pcs', 'Set', 'Box', 'Unit'];
//   static const List<String> _assetClassOptions = [
//     'Class A',
//     'Class B',
//     'Class C',
//   ];
//   static const List<String> _assetCategoryOptions = [
//     'Laptop',
//     'Desktop',
//     'Printer',
//     'Furniture',
//   ];
//   static const List<String> _subCategoryOptions = [
//     'Dell',
//     'HP',
//     'Lenovo',
//     'Other',
//   ];
//   static const List<String> _depreciationMethodOptions = [
//     'Straight Line',
//     'Declining Balance',
//     'None',
//   ];
//   static const List<String> _currencyOptions = ['MMK', 'USD', 'THB'];
//   static const List<String> _accountOptions = ['1', '2', '3'];

//   @override
//   void dispose() {
//     _assetNameController.dispose();
//     _descriptionController.dispose();
//     _brandController.dispose();
//     _modelController.dispose();
//     _serialNumberController.dispose();
//     _quantityController.dispose();
//     _usefulLifeController.dispose();
//     _residualValueController.dispose();
//     _invoiceNoController.dispose();
//     _purchaseCostController.dispose();
//     _otherCapitalizableCostController.dispose();
//     _approvalReferenceController.dispose();
//     _remarksController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = farAssetFormControllerProvider(widget.assetId);
//     final state = ref.watch(provider);
//     final notifier = ref.read(provider.notifier);
//     final isNew = widget.assetId == null;

//     final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);
//     final legalEntityName = currentLegalEntity?.legalEntityName ?? '';

//     final organizationsAsync = ref.watch(organizationsProvider);
//     final partnersAsync = ref.watch(partnersProvider);

//     if (_loadedVersion != state.loadVersion) {
//       _loadedVersion = state.loadVersion;
//       _assetNameController.text = state.assetName;
//       _descriptionController.text = state.description ?? '';
//       _brandController.text = state.brand ?? '';
//       _modelController.text = state.model ?? '';
//       _serialNumberController.text = state.serialNumber ?? '';
//       _quantityController.text = state.quantity?.toString() ?? '';
//       _usefulLifeController.text = state.usefulLife?.toString() ?? '';
//       _residualValueController.text = state.residualValue?.toString() ?? '';
//       _invoiceNoController.text = state.invoiceNo ?? '';
//       _purchaseCostController.text = state.purchaseCost?.toString() ?? '';
//       _otherCapitalizableCostController.text =
//           state.otherCapitalizableCost?.toString() ?? '';
//       _approvalReferenceController.text = state.approvalReference ?? '';
//       _remarksController.text = state.remarks ?? '';
//     }

//     final enabled = !state.loading && !state.saving;

//     return Form(
//       key: _formKey,
//       child: BsMasterEntryPage(
//         // ═══════════════════════════════════════════════════════════
//         // HEADER — Branch Page ပုံစံအတိုင်း ပြင်ထားသည်
//         // ═══════════════════════════════════════════════════════════
//         routeMeta: BsMasterEntryRouteMeta(
//           title: 'Fixed Asset Entry',
//           subtitle: isNew
//               ? 'Create fixed asset profile'
//               : 'Edit fixed asset profile',
//           moduleCode: 'FAR',
//           screenCode: 'FAR_ASSET',
//           recordId: widget.assetId?.toString(),
//           breadcrumb: BsBreadcrumb(
//             items: [
//               const BsBreadcrumbItem(label: 'Home', routePath: '/'),
//               const BsBreadcrumbItem(label: 'Fixed Assets Register'),
//               const BsBreadcrumbItem(
//                 label: 'Core Entity Entry',
//                 routePath: '/far/assets',
//               ),
//               BsBreadcrumbItem(label: isNew ? 'New' : 'Edit'),
//             ],
//           ),
//           status: _buildPageStatus(state),
//         ),

//         // Page actions
//         pageActions: [
//           BsActionButton(
//             label: 'Check Duplicate',
//             icon: Icons.manage_search,
//             onPressed: enabled ? _checkDuplicate : null,
//           ),
//           if (!isNew)
//             BsNewButton(
//               onPressed: state.saving
//                   ? null
//                   : () => _openNew(context, state.isDirty),
//             ),
//         ],

//         // Basic Info — 4 rows flat
//         basicInfo: _buildBasicInfoSection(
//           state: state,
//           notifier: notifier,
//           legalEntityName: legalEntityName,
//           enabled: enabled,
//         ),
//         basicInfoTitle: 'Basic Asset Information',
//         basicInfoStatus: state.status,

//         // Tabs — 4 tabs
//         detailContent: BsTabbedDetailArea(
//           tabs: [
//             BsDetailTab(
//               title: 'Classification',
//               icon: Icons.category_outlined,
//               child: _ClassificationTab(
//                 state: state,
//                 notifier: notifier,
//                 usefulLifeController: _usefulLifeController,
//                 residualValueController: _residualValueController,
//                 assetClassOptions: _assetClassOptions,
//                 assetCategoryOptions: _assetCategoryOptions,
//                 subCategoryOptions: _subCategoryOptions,
//                 depreciationMethodOptions: _depreciationMethodOptions,
//               ),
//             ),
//             BsDetailTab(
//               title: 'Location and Responsibility',
//               icon: Icons.location_on_outlined,
//               child: _LocationTab(
//                 state: state,
//                 notifier: notifier,
//                 organizationsAsync: organizationsAsync,
//                 partnersAsync: partnersAsync,
//               ),
//             ),
//             BsDetailTab(
//               title: 'Financial Information',
//               icon: Icons.attach_money_outlined,
//               child: _FinancialTab(
//                 state: state,
//                 notifier: notifier,
//                 partnersAsync: partnersAsync,
//                 invoiceNoController: _invoiceNoController,
//                 purchaseCostController: _purchaseCostController,
//                 otherCostController: _otherCapitalizableCostController,
//                 currencyOptions: _currencyOptions,
//                 accountOptions: _accountOptions,
//               ),
//             ),
//             BsDetailTab(
//               title: 'Documents / References',
//               icon: Icons.attach_file_outlined,
//               child: _DocumentsTab(
//                 state: state,
//                 notifier: notifier,
//                 approvalReferenceController: _approvalReferenceController,
//                 remarksController: _remarksController,
//               ),
//             ),
//           ],
//         ),

//         // Action bar
//         formActions: BsFormActionBar(
//           isLoading: state.saving,
//           cancelButton: BsCancelButton(
//             onPressed: () => _cancel(context, state.isDirty),
//           ),
//           actions: [
//             BsActionButton(
//               label: 'Save Draft',
//               icon: Icons.mail_outline,
//               onPressed: state.saving
//                   ? null
//                   : () => _saveDraft(context, notifier),
//             ),
//           ],
//           saveButton: BsSaveButton(
//             onPressed: state.saving ? null : () => _save(context, notifier),
//           ),
//         ),

//         isLoading: state.loading || state.saving,
//         isDirty: state.isDirty,
//         onSaveShortcut: state.saving ? null : () => _save(context, notifier),
//         onCancelShortcut: () => _cancel(context, state.isDirty),
//       ),
//     );
//   }

//   // ═══════════════════════════════════════════════════════════
//   // BASIC INFO — 4 flat rows
//   // ═══════════════════════════════════════════════════════════
//   Widget _buildBasicInfoSection({
//     required FarAssetFormState state,
//     required FarAssetFormController notifier,
//     required String legalEntityName,
//     required bool enabled,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 2,
//           children: [
//             BsTextField(
//               label: 'Legal Entity',
//               controller: TextEditingController(text: legalEntityName),
//               enabled: false,
//             ),
//             BsTextField(
//               label: 'Asset Name',
//               controller: _assetNameController,
//               requiredField: true,
//               enabled: enabled,
//               onChanged: notifier.updateAssetName,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 2,
//           children: [
//             BsTextField(
//               label: 'Description',
//               controller: _descriptionController,
//               enabled: enabled,
//               onChanged: notifier.updateDescription,
//             ),
//             BsDropdownField<String>(
//               label: 'Asset Type',
//               value: state.assetType,
//               requiredField: true,
//               items: _assetTypeOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: notifier.updateAssetType,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             BsTextField(
//               label: 'Brand',
//               controller: _brandController,
//               requiredField: true,
//               enabled: enabled,
//               onChanged: notifier.updateBrand,
//             ),
//             BsTextField(
//               label: 'Model',
//               controller: _modelController,
//               requiredField: true,
//               enabled: enabled,
//               onChanged: notifier.updateModel,
//             ),
//             BsTextField(
//               label: 'Serial No',
//               controller: _serialNumberController,
//               requiredField: true,
//               enabled: enabled,
//               onChanged: notifier.updateSerialNumber,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 2,
//           children: [
//             BsTextField(
//               label: 'Quantity',
//               controller: _quantityController,
//               keyboardType: TextInputType.number,
//               enabled: enabled,
//               onChanged: (v) =>
//                   notifier.updateField(quantity: double.tryParse(v)),
//             ),
//             BsDropdownField<String>(
//               label: 'Unit',
//               value: state.unit,
//               items: _unitOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: (v) => notifier.updateField(unit: v),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget? _buildPageStatus(FarAssetFormState state) {
//     if (state.error == null) return null;
//     return Text(
//       state.error!,
//       style: TextStyle(color: Theme.of(context).colorScheme.error),
//     );
//   }

//   void _checkDuplicate() {
//     final name = _assetNameController.text.trim();
//     if (name.isEmpty) {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showValidation('Enter Asset Name before checking duplicate.');
//       return;
//     }
//     ref
//         .read(bsFooterMessageProvider.notifier)
//         .showInfo('Duplicate check is ready for backend integration.');
//   }

//   Future<void> _save(
//     BuildContext context,
//     FarAssetFormController notifier,
//   ) async {
//     if (!(_formKey.currentState?.validate() ?? false)) {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showValidation('Please correct the highlighted fields.');
//       return;
//     }
//     await notifier.save();
//     if (!context.mounted) return;
//     if (notifier.state.error == null) {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showSuccess('Asset saved successfully.');
//       context.go('/far/assets');
//     } else {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showError('Save failed. Please try again.');
//     }
//   }

//   Future<void> _saveDraft(
//     BuildContext context,
//     FarAssetFormController notifier,
//   ) async {
//     if (!(_formKey.currentState?.validate() ?? false)) {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showValidation('Please correct the highlighted fields.');
//       return;
//     }
//     await notifier.saveDraft();
//     if (!context.mounted) return;
//     if (notifier.state.error == null) {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showSuccess('Asset draft saved successfully.');
//       context.go('/far/assets');
//     } else {
//       ref
//           .read(bsFooterMessageProvider.notifier)
//           .showError('Save failed. Please try again.');
//     }
//   }

//   Future<void> _openNew(BuildContext context, bool isDirty) async {
//     final canLeave = await BsFormDirtyGuard.confirmDiscard(
//       context,
//       isDirty: isDirty,
//     );
//     if (canLeave && context.mounted) context.go('/far/assets/new');
//   }

//   Future<void> _cancel(BuildContext context, bool isDirty) async {
//     final canLeave = await BsFormDirtyGuard.confirmDiscard(
//       context,
//       isDirty: isDirty,
//     );
//     if (canLeave && context.mounted) context.go('/far/assets');
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// // TAB 1 — CLASSIFICATION
// // ═══════════════════════════════════════════════════════════════
// class _ClassificationTab extends StatelessWidget {
//   const _ClassificationTab({
//     required this.state,
//     required this.notifier,
//     required this.usefulLifeController,
//     required this.residualValueController,
//     required this.assetClassOptions,
//     required this.assetCategoryOptions,
//     required this.subCategoryOptions,
//     required this.depreciationMethodOptions,
//   });

//   final FarAssetFormState state;
//   final FarAssetFormController notifier;
//   final TextEditingController usefulLifeController;
//   final TextEditingController residualValueController;
//   final List<String> assetClassOptions;
//   final List<String> assetCategoryOptions;
//   final List<String> subCategoryOptions;
//   final List<String> depreciationMethodOptions;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             BsDropdownField<String>(
//               label: 'Asset Class',
//               value: state.assetClass,
//               requiredField: true,
//               items: assetClassOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: notifier.updateAssetClass,
//             ),
//             BsDropdownField<String>(
//               label: 'Asset Category',
//               value: state.assetCategory,
//               requiredField: true,
//               items: assetCategoryOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: notifier.updateAssetCategory,
//             ),
//             BsDropdownField<String>(
//               label: 'Sub-Category',
//               value: state.subCategory,
//               items: subCategoryOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: notifier.updateSubCategory,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             BsDropdownField<String>(
//               label: 'Depreciation Method',
//               value: state.depreciationMethod,
//               items: depreciationMethodOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: notifier.updateDepreciationMethod,
//             ),
//             BsTextField(
//               label: 'Useful Life',
//               keyboardType: TextInputType.number,
//               controller: usefulLifeController,
//               onChanged: (v) => notifier.updateUsefulLife(double.tryParse(v)),
//             ),
//             BsTextField(
//               label: 'Residual Value',
//               keyboardType: TextInputType.number,
//               controller: residualValueController,
//               onChanged: (v) =>
//                   notifier.updateResidualValue(double.tryParse(v)),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// // TAB 2 — LOCATION
// // ═══════════════════════════════════════════════════════════════
// class _LocationTab extends StatelessWidget {
//   const _LocationTab({
//     required this.state,
//     required this.notifier,
//     required this.organizationsAsync,
//     required this.partnersAsync,
//   });

//   final FarAssetFormState state;
//   final FarAssetFormController notifier;
//   final AsyncValue<List<Map<String, dynamic>>> organizationsAsync;
//   final AsyncValue<List<Map<String, dynamic>>> partnersAsync;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             _AsyncBackendDropdown(
//               async: organizationsAsync,
//               label: 'Company',
//               value: state.company,
//               onChanged: notifier.updateCompany,
//             ),
//             _AsyncBackendDropdown(
//               async: organizationsAsync,
//               label: 'Branch',
//               value: state.branch,
//               onChanged: notifier.updateBranch,
//             ),
//             _AsyncBackendDropdown(
//               async: organizationsAsync,
//               label: 'Department',
//               value: state.department,
//               onChanged: notifier.updateDepartment,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 2,
//           children: [
//             _AsyncBackendDropdown(
//               async: organizationsAsync,
//               label: 'Location',
//               value: state.location,
//               onChanged: notifier.updateLocation,
//             ),
//             _AsyncBackendDropdown(
//               async: partnersAsync,
//               label: 'Custodian',
//               value: state.custodian,
//               onChanged: notifier.updateCustodian,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// // TAB 3 — FINANCIAL
// // ═══════════════════════════════════════════════════════════════
// class _FinancialTab extends StatelessWidget {
//   const _FinancialTab({
//     required this.state,
//     required this.notifier,
//     required this.partnersAsync,
//     required this.invoiceNoController,
//     required this.purchaseCostController,
//     required this.otherCostController,
//     required this.currencyOptions,
//     required this.accountOptions,
//   });

//   final FarAssetFormState state;
//   final FarAssetFormController notifier;
//   final AsyncValue<List<Map<String, dynamic>>> partnersAsync;
//   final TextEditingController invoiceNoController;
//   final TextEditingController purchaseCostController;
//   final TextEditingController otherCostController;
//   final List<String> currencyOptions;
//   final List<String> accountOptions;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             BsTextField(
//               label: 'Invoice No',
//               controller: invoiceNoController,
//               onChanged: notifier.updateInvoiceNo,
//             ),
//             _AsyncBackendDropdown(
//               async: partnersAsync,
//               label: 'Supplier',
//               value: state.supplier,
//               onChanged: notifier.updateSupplier,
//             ),
//             BsDateField(
//               label: 'Acquisition Date',
//               controller: TextEditingController(
//                 text: state.acquisitionDate == null
//                     ? ''
//                     : _fmt(state.acquisitionDate!),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             BsTextField(
//               label: 'Purchase Cost',
//               controller: purchaseCostController,
//               keyboardType: TextInputType.number,
//               onChanged: (v) =>
//                   notifier.updateField(purchaseCost: double.tryParse(v)),
//             ),
//             BsTextField(
//               label: 'Other Capitalizable Cost',
//               controller: otherCostController,
//               keyboardType: TextInputType.number,
//               onChanged: (v) => notifier.updateField(
//                 otherCapitalizableCost: double.tryParse(v),
//               ),
//             ),
//             BsDropdownField<String>(
//               label: 'Currency',
//               value: state.currency,
//               items: currencyOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: (v) => notifier.updateField(currency: v),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 3,
//           children: [
//             BsDropdownField<String>(
//               label: 'GL Asset Account',
//               value: state.glAssetAccount?.toString(),
//               items: accountOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: (v) =>
//                   notifier.updateGlAssetAccount(int.tryParse(v ?? '')),
//             ),
//             BsDropdownField<String>(
//               label: 'Accum. Depreciation A/C',
//               value: state.accumDepreciationAccount?.toString(),
//               items: accountOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: (v) => notifier.updateAccumDepreciationAccount(
//                 int.tryParse(v ?? ''),
//               ),
//             ),
//             BsDropdownField<String>(
//               label: 'Depreciation Expense A/C',
//               value: state.depreciationExpenseAccount?.toString(),
//               items: accountOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: (v) => notifier.updateDepreciationExpenseAccount(
//                 int.tryParse(v ?? ''),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 2,
//           children: [
//             BsDropdownField<String>(
//               label: 'Cost Center',
//               value: state.costCenter?.toString(),
//               items: accountOptions
//                   .map(
//                     (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
//                   )
//                   .toList(),
//               onChanged: (v) =>
//                   notifier.updateCostCenter(int.tryParse(v ?? '')),
//             ),
//             BsDateField(
//               label: 'Capitalization Date',
//               controller: TextEditingController(
//                 text: state.capDate == null ? '' : _fmt(state.capDate!),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   static String _fmt(DateTime d) {
//     final m = d.month.toString().padLeft(2, '0');
//     final day = d.day.toString().padLeft(2, '0');
//     return '${d.year}-$m-$day';
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// // TAB 4 — DOCUMENTS
// // ═══════════════════════════════════════════════════════════════
// class _DocumentsTab extends StatelessWidget {
//   const _DocumentsTab({
//     required this.state,
//     required this.notifier,
//     required this.approvalReferenceController,
//     required this.remarksController,
//   });

//   final FarAssetFormState state;
//   final FarAssetFormController notifier;
//   final TextEditingController approvalReferenceController;
//   final TextEditingController remarksController;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 2,
//           children: [
//             BsTextField(
//               label: 'Approval Reference',
//               controller: approvalReferenceController,
//               onChanged: notifier.updateApprovalReference,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         BsFormRow(
//           fieldWidth: 260,
//           maxColumns: 1,
//           children: [
//             BsTextField(
//               label: 'Remarks',
//               controller: remarksController,
//               onChanged: notifier.updateRemarks,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// // ═══════════════════════════════════════════════════════════════
// // ASYNC BACKEND DROPDOWN HELPER
// // ═══════════════════════════════════════════════════════════════
// class _AsyncBackendDropdown extends StatelessWidget {
//   const _AsyncBackendDropdown({
//     required this.async,
//     required this.label,
//     required this.value,
//     required this.onChanged,
//   });

//   final AsyncValue<List<Map<String, dynamic>>> async;
//   final String label;
//   final int? value;
//   final ValueChanged<int?> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return async.when(
//       loading: () => BsTextField(
//         label: label,
//         controller: TextEditingController(text: 'Loading...'),
//         enabled: false,
//       ),
//       error: (e, _) => BsTextField(
//         label: label,
//         controller: TextEditingController(text: 'Error'),
//         enabled: false,
//       ),
//       data: (items) {
//         final mapped = items
//             .map((item) {
//               final id = int.tryParse(item['id']?.toString() ?? '');
//               final name =
//                   item['name']?.toString() ??
//                   item['legal_entity_name']?.toString() ??
//                   item['partner_name']?.toString() ??
//                   item['display_name']?.toString() ??
//                   item['title']?.toString() ??
//                   'ID ${item['id']}';
//               return DropdownMenuItem<int>(
//                 value: id,
//                 child: Text(name, overflow: TextOverflow.ellipsis),
//               );
//             })
//             .where((item) => item.value != null)
//             .toList();

//         final selectedExists = mapped.any((item) => item.value == value);

//         return BsDropdownField<int>(
//           label: label,
//           value: selectedExists ? value : null,
//           items: mapped,
//           onChanged: onChanged,
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/footer/bs_footer_message_provider.dart';
import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

import '../../../../../shared/buttons/bs_action_button.dart';
import '../../../../../shared/buttons/bs_cancel_button.dart';
import '../../../../../shared/buttons/bs_new_button.dart';
import '../../../../../shared/buttons/bs_save_button.dart';

import '../../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../../shared/inputs/bs_text_field.dart';
import '../../../../../shared/inputs/bs_date_field.dart';

import '../../../../../shared/layout/bs_detail_area.dart';
import '../../../../../shared/layout/bs_form_action_bar.dart';
import '../../../../../shared/layout/bs_form_row.dart';
import '../../../../../shared/layout/bs_master_entry_page.dart';

import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';

import '../controller/far_asset_form_controller.dart';
import '../controller/far_asset_dropdown_provider.dart';

class FarAssetFormPage extends ConsumerStatefulWidget {
  const FarAssetFormPage({super.key, this.assetId});
  final int? assetId;

  @override
  ConsumerState<FarAssetFormPage> createState() => _FarAssetFormPageState();
}

class _FarAssetFormPageState extends ConsumerState<FarAssetFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _assetNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _quantityController = TextEditingController();
  final _usefulLifeController = TextEditingController();
  final _residualValueController = TextEditingController();
  final _invoiceNoController = TextEditingController();
  final _purchaseCostController = TextEditingController();
  final _otherCapitalizableCostController = TextEditingController();
  final _approvalReferenceController = TextEditingController();
  final _remarksController = TextEditingController();

  int _loadedVersion = -1;

  // Additional Cost List
  final List<Map<String, dynamic>> _additionalCosts = [];

  static const List<String> _assetTypeOptions = [
    'IT Equipment',
    'Furniture',
    'Vehicle',
  ];
  static const List<String> _unitOptions = ['Pcs', 'Set', 'Box', 'Unit'];
  static const List<String> _assetClassOptions = [
    'Class A',
    'Class B',
    'Class C',
  ];
  static const List<String> _assetCategoryOptions = [
    'Laptop',
    'Desktop',
    'Printer',
    'Furniture',
  ];
  static const List<String> _subCategoryOptions = [
    'Dell',
    'HP',
    'Lenovo',
    'Other',
  ];
  static const List<String> _depreciationMethodOptions = [
    'Straight Line',
    'Declining Balance',
    'None',
  ];
  static const List<String> _currencyOptions = ['MMK', 'USD', 'THB'];
  static const List<String> _accountOptions = ['1', '2', '3'];
  static const List<String> _costTypeOptions = [
    'Transportation',
    'Installation',
    'Customs Duty',
    'Other',
  ];

  @override
  void dispose() {
    _assetNameController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _serialNumberController.dispose();
    _quantityController.dispose();
    _usefulLifeController.dispose();
    _residualValueController.dispose();
    _invoiceNoController.dispose();
    _purchaseCostController.dispose();
    _otherCapitalizableCostController.dispose();
    _approvalReferenceController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = farAssetFormControllerProvider(widget.assetId);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isNew = widget.assetId == null;

    final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);
    final legalEntityName = currentLegalEntity?.legalEntityName ?? '';

    final organizationsAsync = ref.watch(organizationsProvider);
    final partnersAsync = ref.watch(partnersProvider);

    if (_loadedVersion != state.loadVersion) {
      _loadedVersion = state.loadVersion;
      _assetNameController.text = state.assetName;
      _descriptionController.text = state.description ?? '';
      _brandController.text = state.brand ?? '';
      _modelController.text = state.model ?? '';
      _serialNumberController.text = state.serialNumber ?? '';
      _quantityController.text = state.quantity?.toString() ?? '';
      _usefulLifeController.text = state.usefulLife?.toString() ?? '';
      _residualValueController.text = state.residualValue?.toString() ?? '';
      _invoiceNoController.text = state.invoiceNo ?? '';
      _purchaseCostController.text = state.purchaseCost?.toString() ?? '';
      _otherCapitalizableCostController.text =
          state.otherCapitalizableCost?.toString() ?? '';
      _approvalReferenceController.text = state.approvalReference ?? '';
      _remarksController.text = state.remarks ?? '';
    }

    final enabled = !state.loading && !state.saving;

    return Form(
      key: _formKey,
      child: BsMasterEntryPage(
        routeMeta: BsMasterEntryRouteMeta(
          title: 'Fixed Asset Entry',
          subtitle: isNew
              ? 'Create fixed asset profile'
              : 'Edit fixed asset profile',
          moduleCode: 'FAR',
          screenCode: 'FAR_ASSET',
          recordId: widget.assetId?.toString(),
          breadcrumb: BsBreadcrumb(
            items: [
              const BsBreadcrumbItem(label: 'Home', routePath: '/'),
              const BsBreadcrumbItem(label: 'Fixed Assets Register'),
              const BsBreadcrumbItem(
                label: 'Core Entity Entry',
                routePath: '/far/assets',
              ),
              BsBreadcrumbItem(label: isNew ? 'New' : 'Edit'),
            ],
          ),
         
          draftNo: state.draftNo,
          source: state.source,
          draftDate: state.draftDate == null ? '' : _fmtDate(state.draftDate!),
          preparedBy: state.preparedBy,
          lastUpdated: state.lastUpdated == null
              ? ''
              : _fmtDateTime(state.lastUpdated!),
          status: state.status,
        ),

      
        pageActions: [
          BsActionButton(
            label: 'Check Duplicate',
            icon: Icons.manage_search,
            onPressed: enabled ? _checkDuplicate : null,
          ),
          if (!isNew)
            BsNewButton(
              onPressed: state.saving
                  ? null
                  : () => _openNew(context, state.isDirty),
            ),
        ],

        basicInfo: _buildBasicInfoSection(
          state: state,
          notifier: notifier,
          legalEntityName: legalEntityName,
          enabled: enabled,
        ),
        basicInfoTitle: 'Basic Asset Information',
        basicInfoStatus: state.status,
        detailContent: BsTabbedDetailArea(
          tabs: [
            // Tab 1: Classification
            BsDetailTab(
              title: 'Classification',
              icon: Icons.category_outlined,
              child: _ClassificationTab(
                state: state,
                notifier: notifier,
                usefulLifeController: _usefulLifeController,
                residualValueController: _residualValueController,
                assetClassOptions: _assetClassOptions,
                assetCategoryOptions: _assetCategoryOptions,
                subCategoryOptions: _subCategoryOptions,
                depreciationMethodOptions: _depreciationMethodOptions,
              ),
            ),
            // Tab 2: Location and Responsibility
            BsDetailTab(
              title: 'Location and Responsibility',
              icon: Icons.location_on_outlined,
              child: _LocationTab(
                state: state,
                notifier: notifier,
                organizationsAsync: organizationsAsync,
                partnersAsync: partnersAsync,
              ),
            ),
            // Tab 3: Financial Information
            BsDetailTab(
              title: 'Financial Information',
              icon: Icons.attach_money_outlined,
              child: _FinancialTab(
                state: state,
                notifier: notifier,
                partnersAsync: partnersAsync,
                invoiceNoController: _invoiceNoController,
                purchaseCostController: _purchaseCostController,
                otherCostController: _otherCapitalizableCostController,
                currencyOptions: _currencyOptions,
                accountOptions: _accountOptions,
                additionalCosts: _additionalCosts,
                onAddCost: _openAddCostDialog,
                onRemoveCost: (index) {
                  setState(() => _additionalCosts.removeAt(index));
                },
              ),
            ),
            // Tab 4: Documents / References
            BsDetailTab(
              title: 'Documents / References',
              icon: Icons.attach_file_outlined,
              child: _DocumentsTab(
                state: state,
                notifier: notifier,
                approvalReferenceController: _approvalReferenceController,
                remarksController: _remarksController,
              ),
            ),
          ],
        ),

        formActions: BsFormActionBar(
          isLoading: state.saving,
          cancelButton: BsCancelButton(
            onPressed: () => _cancel(context, state.isDirty),
          ),
          actions: [
            // Validate Button
            BsActionButton(
              label: 'Validate',
              icon: Icons.check_circle_outline,
              onPressed: state.saving ? null : _onValidate,
            ),
            // Save & New Button
            BsActionButton(
              label: 'Save & New',
              icon: Icons.save_as_outlined,
              onPressed: state.saving
                  ? null
                  : () => _saveAndNew(context, notifier),
            ),
          ],
          saveButton: BsSaveButton(
            onPressed: state.saving ? null : () => _save(context, notifier),
          ),
        ),

        isLoading: state.loading || state.saving,
        isDirty: state.isDirty,
        onSaveShortcut: state.saving ? null : () => _save(context, notifier),
        onCancelShortcut: () => _cancel(context, state.isDirty),
      ),
    );
  }

  Widget _buildBasicInfoSection({
    required FarAssetFormState state,
    required FarAssetFormController notifier,
    required String legalEntityName,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Asset Name, Description
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            BsTextField(
              label: 'Asset Name',
              controller: _assetNameController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateAssetName,
            ),
            BsTextField(
              label: 'Description',
              controller: _descriptionController,
              enabled: enabled,
              onChanged: notifier.updateDescription,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 2: Asset Type, Brand, Model
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'Asset Type',
              value: state.assetType,
              requiredField: true,
              items: _assetTypeOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateAssetType,
            ),
            BsTextField(
              label: 'Brand',
              controller: _brandController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateBrand,
            ),
            BsTextField(
              label: 'Model',
              controller: _modelController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateModel,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 3: Serial No, Quantity, Unit
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsTextField(
              label: 'Serial No',
              controller: _serialNumberController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateSerialNumber,
            ),
            BsTextField(
              label: 'Quantity',
              controller: _quantityController,
              keyboardType: TextInputType.number,
              enabled: enabled,
              onChanged: (v) =>
                  notifier.updateField(quantity: double.tryParse(v)),
            ),
            BsDropdownField<String>(
              label: 'Unit',
              value: state.unit,
              items: _unitOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) => notifier.updateField(unit: v),
            ),
          ],
        ),
      ],
    );
  }

  Widget? _buildPageStatus(FarAssetFormState state) {
    if (state.error == null) return null;
    return Text(
      state.error!,
      style: TextStyle(color: Theme.of(context).colorScheme.error),
    );
  }
  Future<void> _openAddCostDialog() async {
    final costTypeController = ValueNotifier<String>('Transportation');
    final purchaseCostController = TextEditingController();
    final otherCostController = TextEditingController();
    final currencyController = ValueNotifier<String>('MMK');
    final costDateController = TextEditingController(
      text: _fmtDate(DateTime.now()),
    );
    final descriptionController = TextEditingController();

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Additional Cost'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Cost Type
              BsDropdownField<String>(
                label: 'Cost Type *',
                value: costTypeController.value,
                items: _costTypeOptions
                    .map(
                      (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                    )
                    .toList(),
                onChanged: (v) => costTypeController.value = v ?? '',
              ),
              const SizedBox(height: 12),
              // Purchase Cost
              BsTextField(
                label: 'Purchase Cost',
                controller: purchaseCostController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              // Other Capitalizable Cost
              BsTextField(
                label: 'Other Capitalizable Cost',
                controller: otherCostController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              // Total Capitalizable Cost (Read-only)
              ValueListenableBuilder(
                valueListenable: purchaseCostController,
                builder: (_, __, ___) {
                  return ValueListenableBuilder(
                    valueListenable: otherCostController,
                    builder: (_, __, ___) {
                      final total =
                          (double.tryParse(purchaseCostController.text) ?? 0) +
                          (double.tryParse(otherCostController.text) ?? 0);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calculate, color: Colors.blue),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Total Capitalizable Cost',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Text(
                              total.toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              // Currency
              BsDropdownField<String>(
                label: 'Currency',
                value: currencyController.value,
                items: _currencyOptions
                    .map(
                      (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                    )
                    .toList(),
                onChanged: (v) => currencyController.value = v ?? 'MMK',
              ),
              const SizedBox(height: 12),
              // Cost Date
              BsDateField(label: 'Cost Date', controller: costDateController),
              const SizedBox(height: 12),
              // Description
              BsTextField(
                label: 'Description',
                controller: descriptionController,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop({
                'costType': costTypeController.value,
                'purchaseCost':
                    double.tryParse(purchaseCostController.text) ?? 0,
                'otherCost': double.tryParse(otherCostController.text) ?? 0,
                'total':
                    (double.tryParse(purchaseCostController.text) ?? 0) +
                    (double.tryParse(otherCostController.text) ?? 0),
                'currency': currencyController.value,
                'costDate': costDateController.text,
                'description': descriptionController.text,
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      setState(() => _additionalCosts.add(result));
    }
  }

  void _checkDuplicate() {
    final name = _assetNameController.text.trim();
    if (name.isEmpty) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Enter Asset Name before checking duplicate.');
      return;
    }
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Duplicate check is ready for backend integration.');
  }

  void _onValidate() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    ref
        .read(bsFooterMessageProvider.notifier)
        .showSuccess('Validation passed. Asset is eligible.');
  }

  Future<void> _save(
    BuildContext context,
    FarAssetFormController notifier,
  ) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    await notifier.save();
    if (!context.mounted) return;
    if (notifier.state.error == null) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Asset saved successfully.');
      context.go('/far/assets');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showError('Save failed. Please try again.');
    }
  }

  Future<void> _saveAndNew(
    BuildContext context,
    FarAssetFormController notifier,
  ) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    await notifier.save();
    if (!context.mounted) return;
    if (notifier.state.error == null) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Asset saved. Ready for new entry.');
      context.go('/far/assets/new');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showError('Save failed. Please try again.');
    }
  }

  Future<void> _saveDraft(
    BuildContext context,
    FarAssetFormController notifier,
  ) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    await notifier.saveDraft();
    if (!context.mounted) return;
    if (notifier.state.error == null) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Asset draft saved successfully.');
      context.go('/far/assets');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showError('Save failed. Please try again.');
    }
  }

  Future<void> _openNew(BuildContext context, bool isDirty) async {
    final canLeave = await BsFormDirtyGuard.confirmDiscard(
      context,
      isDirty: isDirty,
    );
    if (canLeave && context.mounted) context.go('/far/assets/new');
  }

  Future<void> _cancel(BuildContext context, bool isDirty) async {
    final canLeave = await BsFormDirtyGuard.confirmDiscard(
      context,
      isDirty: isDirty,
    );
    if (canLeave && context.mounted) context.go('/far/assets');
  }

  static String _fmtDate(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$m/$day/${d.year}';
  }

  static String _fmtDateTime(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final h = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0');
    return '$m/$day/${d.year} $h:$min';
  }
}

class _ClassificationTab extends StatelessWidget {
  const _ClassificationTab({
    required this.state,
    required this.notifier,
    required this.usefulLifeController,
    required this.residualValueController,
    required this.assetClassOptions,
    required this.assetCategoryOptions,
    required this.subCategoryOptions,
    required this.depreciationMethodOptions,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final TextEditingController usefulLifeController;
  final TextEditingController residualValueController;
  final List<String> assetClassOptions;
  final List<String> assetCategoryOptions;
  final List<String> subCategoryOptions;
  final List<String> depreciationMethodOptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'Asset Class',
              value: state.assetClass,
              requiredField: true,
              items: assetClassOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateAssetClass,
            ),
            BsDropdownField<String>(
              label: 'Asset Category',
              value: state.assetCategory,
              requiredField: true,
              items: assetCategoryOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateAssetCategory,
            ),
            BsDropdownField<String>(
              label: 'Sub-Category',
              value: state.subCategory,
              items: subCategoryOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateSubCategory,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'Depreciation Method',
              value: state.depreciationMethod,
              items: depreciationMethodOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateDepreciationMethod,
            ),
            BsTextField(
              label: 'Useful Life',
              keyboardType: TextInputType.number,
              controller: usefulLifeController,
              onChanged: (v) => notifier.updateUsefulLife(double.tryParse(v)),
            ),
            BsTextField(
              label: 'Residual Value',
              keyboardType: TextInputType.number,
              controller: residualValueController,
              onChanged: (v) =>
                  notifier.updateResidualValue(double.tryParse(v)),
            ),
          ],
        ),
      ],
    );
  }
}

class _LocationTab extends StatelessWidget {
  const _LocationTab({
    required this.state,
    required this.notifier,
    required this.organizationsAsync,
    required this.partnersAsync,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final AsyncValue<List<Map<String, dynamic>>> organizationsAsync;
  final AsyncValue<List<Map<String, dynamic>>> partnersAsync;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Company',
              value: state.company,
              onChanged: notifier.updateCompany,
            ),
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Branch',
              value: state.branch,
              onChanged: notifier.updateBranch,
            ),
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Department',
              value: state.department,
              onChanged: notifier.updateDepartment,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Location',
              value: state.location,
              onChanged: notifier.updateLocation,
            ),
            _AsyncBackendDropdown(
              async: partnersAsync,
              label: 'Custodian',
              value: state.custodian,
              onChanged: notifier.updateCustodian,
            ),
          ],
        ),
      ],
    );
  }
}
class _FinancialTab extends StatelessWidget {
  const _FinancialTab({
    required this.state,
    required this.notifier,
    required this.partnersAsync,
    required this.invoiceNoController,
    required this.purchaseCostController,
    required this.otherCostController,
    required this.currencyOptions,
    required this.accountOptions,
    required this.additionalCosts,
    required this.onAddCost,
    required this.onRemoveCost,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final AsyncValue<List<Map<String, dynamic>>> partnersAsync;
  final TextEditingController invoiceNoController;
  final TextEditingController purchaseCostController;
  final TextEditingController otherCostController;
  final List<String> currencyOptions;
  final List<String> accountOptions;
  final List<Map<String, dynamic>> additionalCosts;
  final VoidCallback onAddCost;
  final ValueChanged<int> onRemoveCost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Row 1: Invoice No, Supplier, Acquisition Date
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsTextField(
              label: 'Invoice No',
              controller: invoiceNoController,
              onChanged: notifier.updateInvoiceNo,
            ),
            _AsyncBackendDropdown(
              async: partnersAsync,
              label: 'Supplier',
              value: state.supplier,
              onChanged: notifier.updateSupplier,
            ),
            BsDateField(
              label: 'Acquisition Date',
              controller: TextEditingController(
                text: state.acquisitionDate == null
                    ? ''
                    : _fmt(state.acquisitionDate!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Add Additional Cost Row
        InkWell(
          onTap: onAddCost,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Add Cost (Click + to add cost)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Icon(Icons.add_circle, color: Colors.blue.shade700),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Additional Costs List
        if (additionalCosts.isNotEmpty) ...[
          const Text(
            'Additional Costs',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...additionalCosts.asMap().entries.map((entry) {
            final idx = entry.key;
            final cost = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  '${cost['costType']} - ${cost['total']} ${cost['currency']}',
                ),
                subtitle: Text(
                  '${cost['costDate']}  ${cost['description'] ?? ''}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onRemoveCost(idx),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
        ],

        // Row 2: GL Asset Account, Accum Dep, Dep Expense
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'GL Asset Account',
              value: state.glAssetAccount?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) =>
                  notifier.updateGlAssetAccount(int.tryParse(v ?? '')),
            ),
            BsDropdownField<String>(
              label: 'Accum. Depreciation A/C',
              value: state.accumDepreciationAccount?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) => notifier.updateAccumDepreciationAccount(
                int.tryParse(v ?? ''),
              ),
            ),
            BsDropdownField<String>(
              label: 'Depreciation Expense A/C',
              value: state.depreciationExpenseAccount?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) => notifier.updateDepreciationExpenseAccount(
                int.tryParse(v ?? ''),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Row 3: Cost Center, Capitalization Date
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            BsDropdownField<String>(
              label: 'Cost Center',
              value: state.costCenter?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) =>
                  notifier.updateCostCenter(int.tryParse(v ?? '')),
            ),
            BsDateField(
              label: 'Capitalization Date',
              controller: TextEditingController(
                text: state.capDate == null ? '' : _fmt(state.capDate!),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _fmt(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }
}

class _DocumentsTab extends StatelessWidget {
  const _DocumentsTab({
    required this.state,
    required this.notifier,
    required this.approvalReferenceController,
    required this.remarksController,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final TextEditingController approvalReferenceController;
  final TextEditingController remarksController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Invoice Attachment + PO Attachment
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            _buildFileUploadField(
              context,
              label: 'Invoice Attachment',
              fileName: state.invoiceAttachment, 
            ),
            _buildFileUploadField(
              context,
              label: 'PO Attachment',
              fileName: state.poAttachment, 
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Approval Reference
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 1,
          children: [
            BsTextField(
              label: 'Approval Reference',
              controller: approvalReferenceController,
              onChanged: notifier.updateApprovalReference,
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Remarks
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 1,
          children: [
            BsTextField(
              label: 'Remarks',
              controller: remarksController,
              onChanged: notifier.updateRemarks,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileUploadField(
    BuildContext context, {
    required String label,
    String? fileName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  fileName ?? 'Upload File',
                  style: TextStyle(
                    color: fileName == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.upload_file),
                onPressed: () {
                  // TODO: Pick file
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AsyncBackendDropdown extends StatelessWidget {
  const _AsyncBackendDropdown({
    required this.async,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final AsyncValue<List<Map<String, dynamic>>> async;
  final String label;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return async.when(
      loading: () => BsTextField(
        label: label,
        controller: TextEditingController(text: 'Loading...'),
        enabled: false,
      ),
      error: (e, _) => BsTextField(
        label: label,
        controller: TextEditingController(text: 'Error'),
        enabled: false,
      ),
      data: (items) {
        final mapped = items
            .map((item) {
              final id = int.tryParse(item['id']?.toString() ?? '');
              final name =
                  item['name']?.toString() ??
                  item['legal_entity_name']?.toString() ??
                  item['partner_name']?.toString() ??
                  item['display_name']?.toString() ??
                  item['title']?.toString() ??
                  'ID ${item['id']}';
              return DropdownMenuItem<int>(
                value: id,
                child: Text(name, overflow: TextOverflow.ellipsis),
              );
            })
            .where((item) => item.value != null)
            .toList();

        final selectedExists = mapped.any((item) => item.value == value);

        return BsDropdownField<int>(
          label: label,
          value: selectedExists ? value : null,
          items: mapped,
          onChanged: onChanged,
        );
      },
    );
  }
}
