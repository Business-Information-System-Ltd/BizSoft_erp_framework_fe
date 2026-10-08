/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_section_card.dart
 Purpose      : standard form and page section card.
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

class BsSectionCard extends StatefulWidget {
  const BsSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = true,
    this.compact = true,
  });

  final String title;
  final Widget child;
  final bool initiallyExpanded;
  final bool compact;

  @override
  State<BsSectionCard> createState() => _BsSectionCardState();
}

class _BsSectionCardState extends State<BsSectionCard> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final padding = widget.compact ? 12.0 : 16.0;
    final spacing = widget.compact ? 8.0 : 12.0;

    return Card(
      margin: EdgeInsets.symmetric(vertical: widget.compact ? 6 : 8),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
            ),
            if (_expanded) ...[SizedBox(height: spacing), widget.child],
          ],
        ),
      ),
    );
  }
}
