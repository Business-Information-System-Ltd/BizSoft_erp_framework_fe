/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_legal_entity_selector.dart
 Purpose      : Header Legal Entity selector based on user rights.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - Legal Entity data comes from the real API.
 - Only Legal Entities allowed for the current user are displayed.
 - The selected Legal Entity becomes the application's current working
   Legal Entity.
 - This replaces the mock Company selector in the application header.

===============================================================================
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/legal_entity/bs_current_legal_entity_provider.dart';

import '../../modules/common_setup/legal_entity/domain/model/legal_entity.dart';

class BsLegalEntitySelector
    extends ConsumerWidget {
  const BsLegalEntitySelector({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final legalEntities =
        ref.watch(
      bsAllowedLegalEntitiesProvider,
    );

    final currentLegalEntity =
        ref.watch(
      bsCurrentLegalEntityProvider,
    );

    final theme =
        Theme.of(context);

    if (legalEntities.isEmpty) {
      return Container(
        height: 42,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: theme
                .colorScheme
                .outlineVariant,
          ),
          borderRadius:
              BorderRadius.circular(3),
        ),
        alignment:
            Alignment.centerLeft,
        child: Text(
          'No Legal Entity',
          style: theme
              .textTheme
              .titleSmall,
        ),
      );
    }

    final selected =
        currentLegalEntity ??
            legalEntities.first;

    return PopupMenuButton<int>(
      tooltip:
          'Change Legal Entity',

      offset:
          const Offset(0, 42),

      onSelected: (
        legalEntityId,
      ) {
        final selectedEntity =
            legalEntities.firstWhere(
          (entity) =>
              entity.id ==
              legalEntityId,
        );

        ref
            .read(
              bsCurrentLegalEntityProvider
                  .notifier,
            )
            .state = selectedEntity;
      },

      itemBuilder: (
        context,
      ) {
        return legalEntities
            .map(
              (
                legalEntity,
              ) {
                return PopupMenuItem<int>(
                  value:
                      legalEntity.id,

                  child:
                      _LegalEntityMenuItem(
                    legalEntity:
                        legalEntity,
                    selected:
                        legalEntity.id ==
                            selected.id,
                  ),
                );
              },
            )
            .toList();
      },

      child: Container(
        height: 42,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 8,
        ),

        decoration:
            BoxDecoration(
          border: Border.all(
            color: theme
                .colorScheme
                .outlineVariant,
          ),

          borderRadius:
              BorderRadius.circular(3),

          color: theme
              .colorScheme
              .surface,
        ),

        child: Row(
          mainAxisSize:
              MainAxisSize.min,

          children: [
            const Icon(
              Icons.business_outlined,
              size: 20,
            ),

            const SizedBox(
              width: 10,
            ),

            ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 300,
              ),

              child: Text(
                selected.displayName,

                overflow:
                    TextOverflow.ellipsis,

                style: theme
                    .textTheme
                    .titleSmall,
              ),
            ),

            const SizedBox(
              width: 6,
            ),

            const Icon(
              Icons.keyboard_arrow_down,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalEntityMenuItem
    extends StatelessWidget {
  const _LegalEntityMenuItem({
    required this.legalEntity,
    required this.selected,
  });

  final LegalEntity legalEntity;

  final bool selected;

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,

          alignment:
              Alignment.center,

          decoration:
              BoxDecoration(
            borderRadius:
                BorderRadius.circular(
              4,
            ),

            color: theme
                .colorScheme
                .primaryContainer,
          ),

          child: Text(
            _initials(
              legalEntity
                  .legalEntityName,
            ),

            style: theme
                .textTheme
                .labelMedium,
          ),
        ),

        const SizedBox(
          width: 10,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              Text(
                legalEntity
                    .legalEntityName,

                overflow:
                    TextOverflow.ellipsis,
              ),

              Text(
                legalEntity
                    .legalEntityCode,

                style: theme
                    .textTheme
                    .labelSmall,
              ),
            ],
          ),
        ),

        if (selected)
          const Icon(
            Icons.check,
            size: 18,
          ),
      ],
    );
  }

  String _initials(
    String value,
  ) {
    final parts = value
        .trim()
        .split(
          RegExp(
            r'\s+',
          ),
        )
        .where(
          (part) =>
              part.isNotEmpty,
        )
        .toList();

    if (parts.isEmpty) {
      return 'LE';
    }

    if (parts.length == 1) {
      final text =
          parts.first;

      return text
          .substring(
            0,
            text.length >= 2
                ? 2
                : 1,
          )
          .toUpperCase();
    }

    return parts
        .take(2)
        .map(
          (part) =>
              part[0]
                  .toUpperCase(),
        )
        .join();
  }
}