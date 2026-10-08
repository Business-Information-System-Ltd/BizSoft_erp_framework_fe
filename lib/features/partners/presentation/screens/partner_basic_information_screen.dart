/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/screens/partner_basic_information_screen.dart
 *
 * Purpose:
 *   Standalone Partner Master entry screen based on BsMasterEntryPage.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier, Customer, Employee, Doctor, Patient, Bank, and other profiles extend Partner.
 *   - Partner role and relationship are decided by caller program or backend onboarding service.
 *   - UI must not enforce final business policy; backend is the source of truth.
 *   - API calls must go through Repository and API Service.
 *   - First identity is displayed on the main form.
 *   - Additional identities are entered through dialog, side panel, or accordion.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/bs_permission_provider.dart';
import '../../../../core/company/bs_company_provider.dart';
import '../../../../core/footer/bs_footer_message_provider.dart';
import '../../../../core/validators/bs_validation_message.dart';
import '../../../../shared/buttons/bs_action_button.dart';
import '../../../../shared/buttons/bs_cancel_button.dart';
import '../../../../shared/buttons/bs_save_button.dart';
import '../../../../shared/feedback/bs_validation_message_panel.dart';
import '../../../../shared/layout/bs_form_action_bar.dart';
import '../../../../shared/layout/bs_master_entry_page.dart';
import '../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../shared/navigation/bs_breadcrumb_item.dart';
import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';
import '../widgets/partner_basic_information.dart';
import '../widgets/partner_context_info_section.dart';

class PartnerBasicInformationScreen extends ConsumerStatefulWidget {
  const PartnerBasicInformationScreen({super.key, this.partnerId});

  final String? partnerId;

  @override
  ConsumerState<PartnerBasicInformationScreen> createState() =>
      _PartnerBasicInformationScreenState();
}

class _PartnerBasicInformationScreenState
    extends ConsumerState<PartnerBasicInformationScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(_initialize);
  }

  void _initialize() {
    final company = ref.read(bsSelectedCompanyProvider);
    final user = ref.read(bsCurrentUserProvider);
    ref
        .read(partnerBasicInformationFormProvider.notifier)
        .initializeWithContext(
          PartnerBasicInformationCallerContext(
            callerProgram: 'Partner Master',
            entryMode: 'PARTNER',
            currentLegalEntityId: company.id,
            currentLegalEntityName: company.name,
            currentOrganizationUnitId: company.code,
            currentOrganizationUnitName: company.name,
            isPartnerTypeEditable: true,
            isEmbeddedMode: false,
            preselectedRole: null,
            preselectedRelationship: null,
          ),
        );
    if (user.userId.isEmpty) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showWarning('User context is not available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(partnerBasicInformationFormProvider);
    final notifier = ref.read(partnerBasicInformationFormProvider.notifier);

    return BsMasterEntryPage(
      routeMeta: BsMasterEntryRouteMeta(
        title: 'Partner Basic Information',
        subtitle: 'Create common business partner profile',
        moduleCode: 'COMMON',
        screenCode: 'PARTNER_BASIC_INFORMATION',
        recordId: widget.partnerId,
        breadcrumb: const BsBreadcrumb(
          items: [
            BsBreadcrumbItem(label: 'Home', routePath: '/'),
            BsBreadcrumbItem(label: 'Common Setup'),
            BsBreadcrumbItem(label: 'Partner Master'),
          ],
        ),
      ),
      pageActions: [
        BsActionButton(
          label: 'Check Duplicate',
          icon: Icons.manage_search_outlined,
          onPressed: state.loading ? null : () => _checkDuplicate(notifier),
        ),
      ],
      basicInfo: PartnerBasicInformation(
        state: state,
        notifier: notifier,
        showContextInfo: true,
        displayMode: PartnerBasicInformationDisplayMode.basicOnly,
        onCheckDuplicate: () => _checkDuplicate(notifier),
      ),
      basicInfoStatus: _formatStatus(state.status),
      basicInfoContextItems: buildPartnerContextItems(state.context),
      detailContent: _PartnerBasicInformationDetailContent(
        state: state,
        notifier: notifier,
        onCheckDuplicate: () => _checkDuplicate(notifier),
      ),
      formActions: BsFormActionBar(
        isLoading: state.saving,
        cancelButton: BsCancelButton(
          onPressed: () => _cancel(context, state.isDirty),
        ),
        actions: [
          BsActionButton(
            label: 'Save Draft',
            icon: Icons.drafts_outlined,
            onPressed: state.saving ? null : () => _saveDraft(notifier),
          ),
        ],
        saveButton: BsSaveButton(
          onPressed: state.saving
              ? null
              : () => _savePartner(context, notifier),
        ),
      ),
      isLoading: state.loading || state.saving,
      isDirty: state.isDirty,
      onSaveShortcut: state.saving
          ? null
          : () => _savePartner(context, notifier),
      onCancelShortcut: () => _cancel(context, state.isDirty),
    );
  }

  String _formatStatus(String status) {
    return status
        .split('_')
        .where((part) => part.isNotEmpty)
        .map((part) => '${part[0]}${part.substring(1).toLowerCase()}')
        .join(' ');
  }

  Future<void> _checkDuplicate(
    PartnerBasicInformationFormNotifier notifier,
  ) async {
    final matches = await notifier.checkDuplicate();
    final footer = ref.read(bsFooterMessageProvider.notifier);
    if (matches.isEmpty) {
      footer.showSuccess('No duplicate found.');
    } else {
      footer.showWarning('Possible duplicate found.');
    }
  }

  Future<void> _saveDraft(PartnerBasicInformationFormNotifier notifier) async {
    await notifier.saveDraft();
    ref
        .read(bsFooterMessageProvider.notifier)
        .showSuccess('Partner draft saved for this session.');
  }

  Future<void> _savePartner(
    BuildContext context,
    PartnerBasicInformationFormNotifier notifier,
  ) async {
    final ok = await notifier.savePartner();
    if (!context.mounted) {
      return;
    }
    if (ok) {
      final savedCode = ref
          .read(partnerBasicInformationFormProvider)
          .partnerCode;
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Partner saved ${savedCode.isEmpty ? '' : savedCode}.');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct Partner Basic Information.');
    }
  }

  Future<void> _cancel(BuildContext context, bool isDirty) async {
    final canLeave = await BsFormDirtyGuard.confirmDiscard(
      context,
      isDirty: isDirty,
    );
    if (canLeave && context.mounted) {
      context.go('/');
    }
  }
}

class _PartnerBasicInformationDetailContent extends StatelessWidget {
  const _PartnerBasicInformationDetailContent({
    required this.state,
    required this.notifier,
    this.onCheckDuplicate,
  });

  final PartnerBasicInformationFormState state;
  final PartnerBasicInformationFormNotifier notifier;
  final VoidCallback? onCheckDuplicate;

  @override
  Widget build(BuildContext context) {
    final messages = _summaryMessages();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BsValidationMessagePanel(messages: messages),
        if (messages.isNotEmpty) const SizedBox(height: 8),
        Expanded(
          child: PartnerBasicInformation(
            state: state,
            notifier: notifier,
            showContextInfo: false,
            displayMode: PartnerBasicInformationDisplayMode.detailOnly,
            onCheckDuplicate: onCheckDuplicate,
          ),
        ),
      ],
    );
  }

  List<BsValidationMessage> _summaryMessages() {
    final errors = state.validationErrors;
    if (errors.length <= 1 &&
        !errors.containsKey('save') &&
        !errors.containsKey('duplicate') &&
        !errors.containsKey('contactPerson') &&
        !errors.containsKey('contactPersonDetail')) {
      return const <BsValidationMessage>[];
    }

    return [
      for (final entry in errors.entries)
        BsValidationMessage(fieldName: entry.key, message: entry.value),
    ];
  }
}
