/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_form_provider.dart
 Purpose      : *   Manages Partner create/edit form save and action state.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/partner_repository.dart';
import '../../domain/enums/partner_enums.dart';
import '../../domain/models/partner_model.dart';
import 'partner_providers.dart';

class PartnerFormState {
  const PartnerFormState({
    required this.partner,
    this.saving = false,
    this.dirty = false,
    this.successMessage,
    this.error,
    this.validationErrors = const <String, String>{},
  });

  final PartnerModel partner;
  final bool saving;
  final bool dirty;
  final String? successMessage;
  final String? error;
  final Map<String, String> validationErrors;

  bool get isNew => partner.id == null;

  PartnerFormState copyWith({
    PartnerModel? partner,
    bool? saving,
    bool? dirty,
    String? successMessage,
    String? error,
    Map<String, String>? validationErrors,
    bool clearMessages = false,
  }) => PartnerFormState(
    partner: partner ?? this.partner,
    saving: saving ?? this.saving,
    dirty: dirty ?? this.dirty,
    successMessage: clearMessages
        ? null
        : successMessage ?? this.successMessage,
    error: clearMessages ? null : error ?? this.error,
    validationErrors: validationErrors ?? this.validationErrors,
  );
}

class PartnerFormNotifier extends StateNotifier<PartnerFormState> {
  PartnerFormNotifier(this._repository, PartnerModel initialPartner)
    : super(PartnerFormState(partner: initialPartner));

  final PartnerRepository _repository;

  void update(PartnerModel partner) {
    state = state.copyWith(partner: partner, dirty: true, clearMessages: true);
  }

  Future<PartnerModel?> save() async {
    final validationErrors = _validate(state.partner);
    if (validationErrors.isNotEmpty) {
      state = state.copyWith(
        validationErrors: validationErrors,
        error: 'Please correct the highlighted fields.',
      );
      return null;
    }

    state = state.copyWith(
      saving: true,
      validationErrors: const <String, String>{},
      clearMessages: true,
    );
    try {
      final saved = state.isNew
          ? await _repository.createPartner(
              state.partner.copyWith(status: PartnerStatus.draft),
            )
          : await _repository.updatePartner(state.partner);
      state = state.copyWith(
        partner: saved,
        saving: false,
        dirty: false,
        successMessage: 'Partner saved successfully.',
      );
      return saved;
    } catch (error) {
      state = state.copyWith(saving: false, error: error.toString());
      return null;
    }
  }

  Future<void> activate() async {
    final id = state.partner.id;
    if (id == null) {
      return;
    }
    state = state.copyWith(saving: true, clearMessages: true);
    try {
      await _repository.activatePartner(id);
      state = state.copyWith(
        partner: state.partner.copyWith(status: PartnerStatus.active),
        saving: false,
        successMessage: 'Partner activated.',
      );
    } catch (error) {
      state = state.copyWith(saving: false, error: error.toString());
    }
  }

  Future<void> block() async {
    final id = state.partner.id;
    if (id == null) {
      return;
    }
    state = state.copyWith(saving: true, clearMessages: true);
    try {
      await _repository.blockPartner(id);
      state = state.copyWith(
        partner: state.partner.copyWith(status: PartnerStatus.blocked),
        saving: false,
        successMessage: 'Partner blocked.',
      );
    } catch (error) {
      state = state.copyWith(saving: false, error: error.toString());
    }
  }

  Map<String, String> _validate(PartnerModel partner) {
    final errors = <String, String>{};
    if ((partner.displayName ?? '').trim().isEmpty) {
      errors['display_name'] = 'Display name is required.';
    }
    if ((partner.countryCode ?? '').trim().isEmpty) {
      errors['country_code'] = 'Country is required.';
    }
    if ((partner.defaultCurrencyCode ?? '').trim().isEmpty) {
      errors['default_currency_code'] = 'Currency is required.';
    }
    return errors;
  }
}

final partnerFormProvider =
    StateNotifierProvider.family<
      PartnerFormNotifier,
      PartnerFormState,
      PartnerModel
    >(
      (ref, partner) =>
          PartnerFormNotifier(ref.watch(partnerRepositoryProvider), partner),
    );
