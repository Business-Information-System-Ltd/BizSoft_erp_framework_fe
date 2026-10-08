/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_detail_area.dart
 Purpose      : Reusable detail area widgets for master entry pages.
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

import '../../app/bs_app_theme.dart';
import '../../core/widgets/compact_erp_tab_bar.dart';

class BsDetailTab {
  const BsDetailTab({
    required this.title,
    required this.child,
    this.icon,
    this.enabled = true,
  });

  final String title;
  final Widget child;
  final IconData? icon;
  final bool enabled;
}

class BsTabbedDetailArea extends StatelessWidget {
  const BsTabbedDetailArea({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
  });

  final List<BsDetailTab> tabs;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    if (tabs.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex.clamp(0, tabs.length - 1),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(BsAppTheme.sectionRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                border: Border(
                  bottom: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
              ),
              child: CompactErpTabBar(
                labels: [for (final tab in tabs) tab.title],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for (final tab in tabs)
                    _DetailTabBody(enabled: tab.enabled, child: tab.child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailTabBody extends StatelessWidget {
  const _DetailTabBody({required this.enabled, required this.child});

  final bool enabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1 : 0.56,
        child: Padding(padding: const EdgeInsets.all(12), child: child),
      ),
    );
  }
}

class BsAccordionSection {
  const BsAccordionSection({
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
    this.initiallyExpanded = false,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget child;
  final bool initiallyExpanded;
}

class BsAccordionDetailArea extends StatelessWidget {
  const BsAccordionDetailArea({super.key, required this.sections});

  final List<BsAccordionSection> sections;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: sections.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final section = sections[index];
        return BsDetailSection(
          title: section.title,
          subtitle: section.subtitle,
          icon: section.icon,
          initiallyExpanded: section.initiallyExpanded,
          child: section.child,
        );
      },
    );
  }
}

class BsDetailSection extends StatefulWidget {
  const BsDetailSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.icon,
    this.actions = const <Widget>[],
    this.initiallyExpanded = true,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget> actions;
  final Widget child;
  final bool initiallyExpanded;

  @override
  State<BsDetailSection> createState() =>
      _BsDetailSectionState();
}

class _BsDetailSectionState
    extends State<BsDetailSection> {

  late bool _expanded =
      widget.initiallyExpanded;

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    return LayoutBuilder(
      builder: (
        context,
        constraints,
      ) {
        final hasBoundedHeight =
            constraints.hasBoundedHeight;

        return DecoratedBox(
          decoration: BoxDecoration(
            color:
                theme.colorScheme.surface,

            border: Border.all(
              color:
                  theme.colorScheme
                      .outlineVariant,
            ),

            borderRadius:
                BorderRadius.circular(
              BsAppTheme.sectionRadius,
            ),
          ),

          child: Padding(
            padding:
                const EdgeInsets.all(10),

            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [

                InkWell(
                  borderRadius:
                      BorderRadius.circular(
                    BsAppTheme.radius,
                  ),

                  onTap: () {
                    setState(
                      () => _expanded =
                          !_expanded,
                    );
                  },

                  child: Row(
                    children: [

                      if (widget.icon != null) ...[
                        Icon(
                          widget.icon,
                          size: 18,
                          color:
                              theme.colorScheme
                                  .primary,
                        ),

                        const SizedBox(
                          width: 8,
                        ),
                      ],

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              widget.title,
                              style:
                                  theme.textTheme
                                      .titleSmall,
                            ),

                            if (widget.subtitle != null)
                              Text(
                                widget.subtitle!,
                                style:
                                    theme.textTheme
                                        .bodySmall,
                              ),
                          ],
                        ),
                      ),

                      if (widget.actions.isNotEmpty)
                        Wrap(
                          spacing: 6,
                          children:
                              widget.actions,
                        ),

                      Icon(
                        _expanded
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                    ],
                  ),
                ),

                if (_expanded) ...[
                  const SizedBox(
                    height: 8,
                  ),

                  if (hasBoundedHeight)
                    Expanded(
                      child:
                          SingleChildScrollView(
                        child:
                            widget.child,
                      ),
                    )
                  else
                    widget.child,
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
class BsDetailGridSection extends StatelessWidget {
  const BsDetailGridSection({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.actions = const <Widget>[],
    this.height = 220,
    this.initiallyExpanded = true,
  });

  final String title;
  final String? subtitle;
  final List<Widget> actions;
  final Widget child;
  final double height;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return BsDetailSection(
      title: title,
      subtitle: subtitle,
      icon: Icons.table_rows_outlined,
      actions: actions,
      initiallyExpanded: initiallyExpanded,
      child: SizedBox(height: height, child: child),
    );
  }
}
