/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/screens/supplier_form_screen.dart
 *
 * Purpose:
 *   Example supplier onboarding screen embedding PartnerBasicInformation.
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
import '../../../../shared/layout/bs_detail_area.dart';
import '../../../../shared/layout/bs_form_action_bar.dart';
import '../../../../shared/layout/bs_master_entry_page.dart';
import '../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../shared/navigation/bs_breadcrumb_item.dart';
import '../../../partners/presentation/providers/partner_basic_information_form_provider.dart';
import '../../../partners/presentation/state/partner_basic_information_form_state.dart';
import '../../../partners/presentation/widgets/partner_basic_information.dart';
import '../../../partners/presentation/widgets/partner_context_info_section.dart';
import '../providers/supplier_form_provider.dart';
import '../state/supplier_form_state.dart';
import '../widgets/supplier_accounting_defaults_section.dart';
import '../widgets/supplier_bank_information_section.dart';
import '../widgets/supplier_payment_settings_section.dart';
import '../widgets/supplier_profile_section.dart';
import '../widgets/supplier_tax_settings_section.dart';

class SupplierFormScreen extends ConsumerStatefulWidget {
  const SupplierFormScreen({super.key, this.supplierId});

  final String? supplierId;

  @override
  ConsumerState<SupplierFormScreen> createState() => _SupplierFormScreenState();
}

class _SupplierFormScreenState extends ConsumerState<SupplierFormScreen> {
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
            callerProgram: 'Supplier Entry',
            entryMode: 'SUPPLIER',
            preselectedPartnerType: 'LEGAL_PERSON',
            preselectedRole: 'SUPPLIER',
            preselectedRelationship: 'SUPPLIER_OF',
            currentLegalEntityId: company.id,
            currentLegalEntityName: company.name,
            currentOrganizationUnitId: company.code,
            currentOrganizationUnitName: company.name,
            isPartnerTypeEditable: true,
            isEmbeddedMode: true,
          ),
        );
    ref
        .read(supplierFormProvider.notifier)
        .initialize(supplierId: widget.supplierId);
    if (user.userId.isEmpty) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showWarning('User context is not available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final partnerState = ref.watch(partnerBasicInformationFormProvider);
    final partnerNotifier = ref.read(
      partnerBasicInformationFormProvider.notifier,
    );
    final supplierState = ref.watch(supplierFormProvider);
    final supplierNotifier = ref.read(supplierFormProvider.notifier);
    final isSaving = partnerState.saving || supplierState.saving;
    final isDirty = partnerState.isDirty || supplierState.isDirty;

    return BsMasterEntryPage(
      routeMeta: BsMasterEntryRouteMeta(
        title: 'Supplier Entry',
        subtitle: 'Create supplier by extending common Partner information',
        moduleCode: 'COMMON',
        screenCode: 'SUPPLIER_ENTRY',
        recordId: widget.supplierId,
        breadcrumb: const BsBreadcrumb(
          items: [
            BsBreadcrumbItem(label: 'Home', routePath: '/'),
            BsBreadcrumbItem(label: 'Common Setup'),
            BsBreadcrumbItem(label: 'Supplier'),
          ],
        ),
      ),
      pageActions: [
        BsActionButton(
          label: 'Check Duplicate',
          icon: Icons.manage_search_outlined,
          onPressed: isSaving ? null : () => _checkDuplicate(partnerNotifier),
        ),
      ],
      basicInfo: PartnerBasicInformation(
        state: partnerState,
        notifier: partnerNotifier,
        isEmbeddedMode: true,
        showContextInfo: true,
        displayMode: PartnerBasicInformationDisplayMode.basicOnly,
        onCheckDuplicate: () => _checkDuplicate(partnerNotifier),
      ),
      basicInfoStatus: _formatStatus(supplierState.supplierStatus),
      basicInfoContextItems: buildPartnerContextItems(partnerState.context),
      detailContent: _SupplierDetailContent(
        partnerState: partnerState,
        partnerNotifier: partnerNotifier,
        supplierState: supplierState,
        supplierNotifier: supplierNotifier,
      ),
      formActions: BsFormActionBar(
        isLoading: isSaving,
        cancelButton: BsCancelButton(
          onPressed: () => _cancel(context, isDirty),
        ),
        actions: [
          BsActionButton(
            label: 'Save Draft',
            icon: Icons.drafts_outlined,
            onPressed: isSaving
                ? null
                : () => _saveDraft(partnerNotifier, supplierNotifier),
          ),
        ],
        saveButton: BsSaveButton(
          onPressed: isSaving
              ? null
              : () => _saveSupplier(context, partnerNotifier, supplierNotifier),
        ),
      ),
      isLoading: isSaving,
      isDirty: isDirty,
      onSaveShortcut: isSaving
          ? null
          : () => _saveSupplier(context, partnerNotifier, supplierNotifier),
      onCancelShortcut: () => _cancel(context, isDirty),
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

  Future<void> _saveSupplier(
    BuildContext context,
    PartnerBasicInformationFormNotifier partnerNotifier,
    SupplierFormNotifier supplierNotifier,
  ) async {
    final partnerErrors = partnerNotifier.validateForSave();
    if (partnerErrors.isNotEmpty) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct Partner Basic Information.');
      return;
    }

    final ok = await supplierNotifier.saveSupplier(
      partnerNotifier.buildCreateRequest().toJson(),
    );
    if (!context.mounted) {
      return;
    }

    if (ok) {
      final supplierState = ref.read(supplierFormProvider);
      partnerNotifier.markSavedByExtension(
        status: supplierState.supplierStatus,
      );
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Supplier saved ${supplierState.supplierCode}.');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct Supplier information.');
    }
  }

  Future<void> _saveDraft(
    PartnerBasicInformationFormNotifier partnerNotifier,
    SupplierFormNotifier supplierNotifier,
  ) async {
    await partnerNotifier.saveDraft();
    supplierNotifier.saveDraft();
    ref
        .read(bsFooterMessageProvider.notifier)
        .showSuccess('Supplier draft saved for this session.');
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

class _SupplierDetailContent extends StatelessWidget {
  const _SupplierDetailContent({
    required this.partnerState,
    required this.partnerNotifier,
    required this.supplierState,
    required this.supplierNotifier,
  });

  final PartnerBasicInformationFormState partnerState;
  final PartnerBasicInformationFormNotifier partnerNotifier;
  final SupplierFormState supplierState;
  final SupplierFormNotifier supplierNotifier;

  @override
  Widget build(BuildContext context) {
    final messages = _buildMessages();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BsValidationMessagePanel(messages: messages),
        if (messages.isNotEmpty) const SizedBox(height: 10),
        Expanded(
          child: BsTabbedDetailArea(
            tabs: [
              BsDetailTab(
                title: 'Partner',
                child: PartnerBasicInformation(
                  state: partnerState,
                  notifier: partnerNotifier,
                  isEmbeddedMode: true,
                  showContextInfo: false,
                  displayMode: PartnerBasicInformationDisplayMode.detailOnly,
                  showDuplicateCheck: true,
                ),
              ),
              BsDetailTab(
                title: 'Supplier',
                child: ListView(
                  children: [
                    SupplierProfileSection(
                      state: supplierState,
                      notifier: supplierNotifier,
                    ),
                  ],
                ),
              ),
              BsDetailTab(
                title: 'Bank',
                child: ListView(
                  children: [
                    SupplierBankInformationSection(
                      state: supplierState,
                      notifier: supplierNotifier,
                    ),
                  ],
                ),
              ),
              BsDetailTab(
                title: 'Payment',
                child: ListView(
                  children: [
                    SupplierPaymentSettingsSection(
                      state: supplierState,
                      notifier: supplierNotifier,
                    ),
                  ],
                ),
              ),
              BsDetailTab(
                title: 'Tax',
                child: ListView(
                  children: [
                    SupplierTaxSettingsSection(
                      state: supplierState,
                      notifier: supplierNotifier,
                    ),
                  ],
                ),
              ),
              BsDetailTab(
                title: 'Accounting',
                child: ListView(
                  children: [
                    SupplierAccountingDefaultsSection(
                      state: supplierState,
                      notifier: supplierNotifier,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<BsValidationMessage> _buildMessages() {
    final errors = {
      ...partnerState.validationErrors,
      ...supplierState.validationErrors,
    };
    if (errors.length <= 1 &&
        !errors.containsKey('save') &&
        !errors.containsKey('duplicate') &&
        !errors.containsKey('contactPerson') &&
        !errors.containsKey('contactPersonDetail')) {
      return const <BsValidationMessage>[];
    }

    return [
      for (final entry in partnerState.validationErrors.entries)
        BsValidationMessage(fieldName: entry.key, message: entry.value),
      for (final entry in supplierState.validationErrors.entries)
        BsValidationMessage(fieldName: entry.key, message: entry.value),
    ];
  }
}
