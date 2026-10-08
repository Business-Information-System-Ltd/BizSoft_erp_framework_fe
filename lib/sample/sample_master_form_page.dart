/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : sample_master_form_page.dart
 Purpose      : Sample master form page demonstrating standard action placement.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/footer/bs_footer_message_provider.dart';
import '../core/validators/bs_validation_message.dart';
import '../shared/buttons/bs_action_button.dart';
import '../shared/buttons/bs_cancel_button.dart';
import '../shared/buttons/bs_delete_button.dart';
import '../shared/buttons/bs_new_button.dart';
import '../shared/buttons/bs_refresh_button.dart';
import '../shared/buttons/bs_save_button.dart';
import '../shared/dialogs/bs_confirm_dialog.dart';
import '../shared/feedback/bs_loading_overlay.dart';
import '../shared/feedback/bs_validation_message_panel.dart';
import '../shared/inputs/bs_date_field.dart';
import '../shared/inputs/bs_dropdown_field.dart';
import '../shared/inputs/bs_text_area_field.dart';
import '../shared/inputs/bs_text_field.dart';
import '../shared/layout/bs_form_action_bar.dart';
import '../shared/layout/bs_form_row.dart';
import '../shared/layout/bs_page.dart';
import '../shared/layout/bs_page_header.dart';
import '../shared/layout/bs_section_card.dart';
import '../shared/navigation/bs_breadcrumb.dart';
import '../shared/navigation/bs_breadcrumb_item.dart';

class SampleMasterFormPage extends ConsumerStatefulWidget {
  const SampleMasterFormPage({super.key});

  @override
  ConsumerState<SampleMasterFormPage> createState() =>
      _SampleMasterFormPageState();
}

class _SampleMasterFormPageState extends ConsumerState<SampleMasterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _remarksController = TextEditingController();
  String? _type = 'standard';
  bool _saving = false;
  List<BsValidationMessage> _messages = const <BsValidationMessage>[];

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _dateController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BsPage(
      title: 'Sample Master Form',
      breadcrumb: const BsBreadcrumb(
        items: [
          BsBreadcrumbItem(label: 'Home', routePath: '/'),
          BsBreadcrumbItem(label: 'Sample'),
          BsBreadcrumbItem(label: 'Master Form'),
        ],
      ),
      header: BsPageHeader(
        title: 'Sample Master Form',
        subtitle: 'Upper-right actions are page/document actions only.',
        actions: [
          BsNewButton(onPressed: _newRecord),
          BsActionButton(
            label: 'Edit',
            icon: Icons.edit_outlined,
            onPressed: () => _showActionMessage('Edit'),
          ),
          BsDeleteButton(onPressed: _deleteRecord),
          BsRefreshButton(onPressed: _refreshRecord),
        ],
      ),
      messagePanel: BsValidationMessagePanel(messages: _messages),
      body: BsLoadingOverlay(
        isLoading: _saving,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              BsSectionCard(
                title: 'General Information',
                compact: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BsFormRow(
                      children: [
                        BsTextField(
                          label: 'Code',
                          controller: _codeController,
                          requiredField: true,
                        ),
                        BsTextField(
                          label: 'Name',
                          controller: _nameController,
                          requiredField: true,
                        ),
                        BsDropdownField<String>(
                          label: 'Type',
                          value: _type,
                          requiredField: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'standard',
                              child: Text('Standard'),
                            ),
                            DropdownMenuItem(
                              value: 'special',
                              child: Text('Special'),
                            ),
                          ],
                          onChanged: (value) => setState(() => _type = value),
                        ),
                        BsDateField(
                          label: 'Effective Date',
                          controller: _dateController,
                          requiredField: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    BsTextAreaField(
                      label: 'Remarks',
                      controller: _remarksController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      footer: BsFormActionBar(
        isLoading: _saving,
        cancelButton: BsCancelButton(onPressed: () => context.go('/')),
        saveButton: BsSaveButton(onPressed: _saving ? null : _save),
      ),
    );
  }

  void _newRecord() {
    _codeController.clear();
    _nameController.clear();
    _dateController.clear();
    _remarksController.clear();
    setState(() {
      _type = 'standard';
      _messages = const <BsValidationMessage>[];
    });
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Ready for new record.');
  }

  void _refreshRecord() {
    setState(() {
      _messages = const [
        BsValidationMessage(
          message: 'Sample record refreshed.',
          type: BsValidationMessageType.info,
        ),
      ];
    });
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Sample record refreshed.');
  }

  Future<void> _deleteRecord() async {
    final ok = await BsConfirmDialog.show(
      context: context,
      title: 'Delete Record',
      message: 'Do you want to delete this sample record?',
    );
    if (!ok) {
      return;
    }
    _newRecord();
    setState(() {
      _messages = const [
        BsValidationMessage(
          message: 'Sample record deleted.',
          type: BsValidationMessageType.warning,
        ),
      ];
    });
    ref
        .read(bsFooterMessageProvider.notifier)
        .showWarning('Sample record deleted.');
  }

  void _showActionMessage(String action) {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('$action action selected.');
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      setState(() {
        _messages = const [
          BsValidationMessage(
            message: 'Please correct the highlighted fields.',
          ),
        ];
      });
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    final ok = await BsConfirmDialog.show(
      context: context,
      title: 'Save Record',
      message: 'Do you want to save this sample record?',
    );
    if (!ok) {
      return;
    }
    setState(() => _saving = true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    setState(() {
      _saving = false;
      _messages = const [
        BsValidationMessage(
          message: 'Record saved.',
          type: BsValidationMessageType.success,
        ),
      ];
    });
    ref.read(bsFooterMessageProvider.notifier).showSuccess('Record saved.');
  }
}
