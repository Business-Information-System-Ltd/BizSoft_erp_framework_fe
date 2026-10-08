/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : sample_lookup_page.dart
 Purpose      : sample lookup page.
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

import '../shared/lookup/bs_lookup_column.dart';
import '../shared/lookup/bs_lookup_models.dart';
import '../shared/lookup/bs_lookup_search_box.dart';
import '../shared/layout/bs_page.dart';
import '../shared/layout/bs_section_card.dart';

class SampleLookupPage extends StatefulWidget {
  const SampleLookupPage({super.key});

  @override
  State<SampleLookupPage> createState() => _SampleLookupPageState();
}

class _SampleLookupPageState extends State<SampleLookupPage> {
  BsLookupSelectionResult? _selected;

  @override
  Widget build(BuildContext context) {
    return BsPage(
      title: 'Sample Lookup',
      body: BsSectionCard(
        title: 'Lookup Field',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BsLookupSearchBox(
              label: 'Asset / Partner Lookup',
              hintText: 'Type keyword and press / or ?',
              columns: const [
                BsLookupColumn(field: 'id', title: 'ID', width: 80),
                BsLookupColumn(field: 'code', title: 'Code', width: 140),
                BsLookupColumn(field: 'name', title: 'Name', width: 260),
              ],
              search: _search,
              onSelected: (value) => setState(() => _selected = value),
            ),
            const SizedBox(height: 16),
            Text(_selected == null ? 'No selection.' : 'Selected: ${_selected!.code} - ${_selected!.displayText}'),
          ],
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _search(String keyword) async {
    final rows = [
      {'id': 1, 'code': 'AST-001', 'name': 'Laptop Computer'},
      {'id': 2, 'code': 'CUS-001', 'name': 'Yangon Trading'},
      {'id': 3, 'code': 'GL-1000', 'name': 'Cash Account'},
    ];
    return rows.where((row) => row.values.join(' ').toLowerCase().contains(keyword.toLowerCase())).toList();
  }
}
