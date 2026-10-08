/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_lookup_search_box.dart
 Purpose      : large master data lookup field.
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

import 'bs_lookup_column.dart';
import 'bs_lookup_models.dart';
import 'bs_pluto_grid_lookup.dart';

class BsLookupSearchBox extends StatefulWidget {
  const BsLookupSearchBox({
    super.key,
    required this.label,
    required this.columns,
    required this.search,
    required this.onSelected,
    this.hintText,
  });

  final String label;
  final String? hintText;
  final List<BsLookupColumn> columns;
  final Future<List<Map<String, dynamic>>> Function(String keyword) search;
  final ValueChanged<BsLookupSelectionResult> onSelected;

  @override
  State<BsLookupSearchBox> createState() => _BsLookupSearchBoxState();
}

class _BsLookupSearchBoxState extends State<BsLookupSearchBox> {
  final _controller = TextEditingController();
  String? _selectedText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        helperText: _selectedText,
        suffixIcon: IconButton(icon: const Icon(Icons.search), onPressed: _openLookup),
      ),
      onChanged: (value) {
        if (value.endsWith('/') || value.endsWith('?')) {
          _openLookup();
        }
      },
      onSubmitted: (_) => _openLookup(),
    );
  }

  Future<void> _openLookup() async {
    final rows = await widget.search(_controller.text.replaceAll(RegExp(r'[/\?]$'), ''));
    if (!mounted) {
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.label),
        content: SizedBox(
          width: 480,
          child: BsPlutoGridLookup(
            columns: widget.columns,
            rows: rows,
            onSelected: (result) {
              setState(() {
                _controller.text = result.code;
                _selectedText = result.displayText;
              });
              widget.onSelected(result);
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
