/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_search_box.dart
 Purpose      : reusable search box for list and report screens.
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

import 'bs_search_models.dart';
import 'bs_search_parser.dart';
import 'bs_search_popup_table.dart';

class BsSearchBox extends StatefulWidget {
  const BsSearchBox({
    super.key,
    required this.onSearch,
    this.triggerMode = BsSearchTriggerMode.buttonPress,
    this.popupItemsLoader,
    this.hintText = 'Search',
  });

  final ValueChanged<BsSearchRequest> onSearch;
  final BsSearchTriggerMode triggerMode;
  final Future<List<BsSearchPopupItem>> Function(String query)? popupItemsLoader;
  final String hintText;

  @override
  State<BsSearchBox> createState() => _BsSearchBoxState();
}

class _BsSearchBoxState extends State<BsSearchBox> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: widget.triggerMode == BsSearchTriggerMode.buttonPress
            ? IconButton(icon: const Icon(Icons.arrow_forward), onPressed: _emitSearch)
            : null,
      ),
      onChanged: (value) {
        if (value.endsWith('/') || value.endsWith('?')) {
          _showPopup();
        }
        if (widget.triggerMode == BsSearchTriggerMode.textChange) {
          _emitSearch();
        }
      },
      onSubmitted: (_) => _emitSearch(),
    );
  }

  void _emitSearch() {
    widget.onSearch(BsSearchParser.parse(_controller.text));
  }

  Future<void> _showPopup() async {
    final loader = widget.popupItemsLoader;
    if (loader == null) {
      return;
    }
    final items = await loader(_controller.text);
    if (!mounted || items.isEmpty) {
      return;
    }
    _removeOverlay();
    final renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height + 4,
        width: renderBox.size.width,
        child: BsSearchPopupTable(
          items: items,
          onSelected: (item) {
            _controller.text = _controller.text.replaceFirst(RegExp(r'[/\?]$'), item.insertText);
            _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
            _removeOverlay();
            _emitSearch();
          },
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
