// /*
// ===============================================================================
//  BizSoft Frontend Framework
// ===============================================================================

//  File Name    : partner_form_screen.dart
//  Purpose      : *   Provides tabbed Partner create and edit screen with workflow actions.
//  Company      : BizSoft Systems
//  Created By   : BizSoft Frontend Framework Team

//  Notes        :
//  - This is a common framework widget or source file.
//  - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
//  - Use Theme.of(context) to support future theme changes where UI styling is needed.
//  - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

// ===============================================================================
// */
// import 'package:bizsoft_frontend_framework/shared/feedback/bs_loading_overlay.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// import '../../../../core/widgets/app_error_view.dart';

// import '../../../../core/widgets/confirmation_dialog.dart';
// import '../../domain/enums/partner_enums.dart';
// import '../../domain/models/legal_entity_profile_model.dart';
// import '../../domain/models/partner_model.dart';
// import '../../domain/models/person_profile_model.dart';
// import '../providers/partner_detail_provider.dart';
// import '../providers/partner_form_provider.dart';
// import '../widgets/legal_entity_profile_form.dart';
// import '../widgets/partner_basic_info_form.dart';
// import '../widgets/partner_child_sections.dart';
// import '../widgets/partner_status_chip.dart';
// import '../widgets/person_profile_form.dart';

// class PartnerFormScreen extends ConsumerWidget {
//   const PartnerFormScreen({super.key, this.partnerId});

//   final String? partnerId;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     if (partnerId == null) {
//       return _PartnerFormBody(initialPartner: PartnerModel.empty());
//     }

//     final asyncPartner = ref.watch(partnerDetailProvider(partnerId!));
//     return asyncPartner.when(
//       data: (partner) => _PartnerFormBody(initialPartner: partner),
//       loading: () => const Scaffold(body: BsLoadingOverlay(isLoading: true, child: )),
//       error: (error, _) => Scaffold(
//         body: AppErrorView(
//           message: error.toString(),
//           onRetry: () => ref.invalidate(partnerDetailProvider(partnerId!)),
//         ),
//       ),
//     );
//   }
// }

// class _PartnerFormBody extends ConsumerWidget {
//   const _PartnerFormBody({required this.initialPartner});

//   final PartnerModel initialPartner;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final provider = partnerFormProvider(initialPartner);
//     final state = ref.watch(provider);
//     final notifier = ref.read(provider.notifier);
//     final partner = state.partner;

//     ref.listen(partnerFormProvider(initialPartner), (previous, next) {
//       if (next.successMessage != null && next.successMessage != previous?.successMessage) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.successMessage!)));
//       }
//     });

//     return PopScope(
//       canPop: !state.dirty,
//       onPopInvokedWithResult: (didPop, _) async {
//         if (didPop || !state.dirty) {
//           return;
//         }
//         final leave = await showConfirmationDialog(
//           context: context,
//           title: 'Discard changes?',
//           message: 'You have unsaved partner changes.',
//           confirmText: 'Discard',
//         );
//         if (leave && context.mounted) {
//           context.go('/partners');
//         }
//       },
//       child: DefaultTabController(
//         length: 7,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(state.isNew ? 'New Partner' : 'Edit Partner'),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back),
//               onPressed: () => context.go('/partners'),
//             ),
//             actions: [
//               PartnerStatusChip(status: partner.status),
//               const SizedBox(width: 12),
//               FilledButton.icon(
//                 onPressed: state.saving
//                     ? null
//                     : () async {
//                         final saved = await notifier.save();
//                         if (saved?.id != null && context.mounted) {
//                           context.go('/partners/${saved!.id}/edit');
//                         }
//                       },
//                 icon: const Icon(Icons.save),
//                 label: const Text('Save'),
//               ),
//               const SizedBox(width: 8),
//               TextButton.icon(
//                 onPressed: partner.id == null || state.saving
//                     ? null
//                     : () async {
//                         final ok = await showConfirmationDialog(
//                           context: context,
//                           title: 'Activate partner?',
//                           message: 'This partner will be available for module-specific use.',
//                           confirmText: 'Activate',
//                         );
//                         if (ok) {
//                           await notifier.activate();
//                         }
//                       },
//                 icon: const Icon(Icons.check_circle_outline),
//                 label: const Text('Activate'),
//               ),
//               TextButton.icon(
//                 onPressed: partner.id == null || state.saving
//                     ? null
//                     : () async {
//                         final ok = await showConfirmationDialog(
//                           context: context,
//                           title: 'Block partner?',
//                           message: 'Blocked partners should not be used in new transactions.',
//                           confirmText: 'Block',
//                         );
//                         if (ok) {
//                           await notifier.block();
//                         }
//                       },
//                 icon: const Icon(Icons.block),
//                 label: const Text('Block'),
//               ),
//               const SizedBox(width: 12),
//             ],
//             bottom: const TabBar(
//               isScrollable: true,
//               tabs: [
//                 Tab(text: 'Basic'),
//                 Tab(text: 'Profile'),
//                 Tab(text: 'Roles'),
//                 Tab(text: 'Relationships'),
//                 Tab(text: 'Addresses'),
//                 Tab(text: 'Contacts'),
//                 Tab(text: 'Compliance'),
//               ],
//             ),
//           ),
//           body: Column(
//             children: [
//               if (state.saving) const LinearProgressIndicator(),
//               if (state.error != null)
//                 MaterialBanner(
//                   content: Text(state.error!),
//                   actions: [TextButton(onPressed: () {}, child: const Text('OK'))],
//                 ),
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     _TabPadding(
//                       child: PartnerBasicInfoForm(
//                         partner: partner,
//                         errors: state.validationErrors,
//                         onChanged: notifier.update,
//                       ),
//                     ),
//                     _TabPadding(
//                       child: partner.partnerType == PartnerType.naturalPerson
//                           ? PersonProfileForm(
//                               profile: partner.personProfile ?? const PersonProfileModel(),
//                               onChanged: (value) => notifier.update(partner.copyWith(personProfile: value)),
//                             )
//                           : LegalEntityProfileForm(
//                               profile: partner.legalEntityProfile ?? const LegalEntityProfileModel(),
//                               onChanged: (value) => notifier.update(partner.copyWith(legalEntityProfile: value)),
//                             ),
//                     ),
//                     _TabPadding(child: PartnerRoleSection(partner: partner, editable: true)),
//                     _TabPadding(child: PartnerRelationshipSection(partner: partner, editable: true)),
//                     _TabPadding(child: PartnerAddressSection(partner: partner, editable: true)),
//                     _TabPadding(child: PartnerContactSection(partner: partner, editable: true)),
//                     _TabPadding(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           PartnerIdentificationSection(partner: partner, editable: true),
//                           const SizedBox(height: 12),
//                           PartnerRegistrationSection(partner: partner, editable: true),
//                           const SizedBox(height: 12),
//                           PartnerComplianceSection(partner: partner, editable: true),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TabPadding extends StatelessWidget {
//   const _TabPadding({required this.child});

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: child,
//     );
//   }
// }
