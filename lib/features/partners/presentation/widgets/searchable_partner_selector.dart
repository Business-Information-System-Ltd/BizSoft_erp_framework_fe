/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : searchable_partner_selector.dart
 Purpose      : *   Provides a reusable dialog-based Partner lookup selector.
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

import '../../domain/enums/partner_enums.dart';
import '../../domain/models/partner_model.dart';
import '../providers/partner_providers.dart';

class SearchablePartnerSelector extends ConsumerStatefulWidget {
  const SearchablePartnerSelector({
    super.key,
    required this.label,
    required this.onSelected,
    this.selectedText,
  });

  final String label;
  final String? selectedText;
  final ValueChanged<PartnerModel> onSelected;

  @override
  ConsumerState<SearchablePartnerSelector> createState() =>
      _SearchablePartnerSelectorState();
}

class _SearchablePartnerSelectorState
    extends ConsumerState<SearchablePartnerSelector> {
  final _controller = TextEditingController();
  List<PartnerModel> _items = const <PartnerModel>[];
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: widget.label,
        helperText: widget.selectedText,
        suffixIcon: IconButton(
          tooltip: 'Search partner',
          icon: const Icon(Icons.search),
          onPressed: _openSelector,
        ),
      ),
      onTap: _openSelector,
    );
  }

  Future<void> _openSelector() async {
    await showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          Future<void> runSearch() async {
            setDialogState(() => _loading = true);
            final result = await ref
                .read(partnerRepositoryProvider)
                .listPartners(search: _controller.text);
            setDialogState(() {
              _items = result.items;
              _loading = false;
            });
          }

          return AlertDialog(
            title: Text(widget.label),
            content: SizedBox(
              width: 640,
              height: 420,
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: runSearch,
                      ),
                    ),
                    onSubmitted: (_) => runSearch(),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            itemCount: _items.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final item = _items[index];
                              return ListTile(
                                title: Text(
                                  item.displayName ?? item.partnerCode ?? '-',
                                ),
                                subtitle: Text(
                                  item.partnerCode ?? item.partnerType.label,
                                ),
                                onTap: () {
                                  widget.onSelected(item);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }
}
