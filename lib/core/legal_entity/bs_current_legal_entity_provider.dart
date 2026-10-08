/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_current_legal_entity_provider.dart
 Purpose      : Current Legal Entity context based on user rights.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - Legal Entities are loaded from the real API.
 - User rights currently come from the mock BsUserContext.
 - Only Legal Entities allowed for the current user are exposed.
 - The user's default Legal Entity is selected initially.
 - The user can change the current Legal Entity from the header.
 - When real login/user rights become available, only the user-context source
   needs to be replaced.

===============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../modules/common_setup/legal_entity/domain/model/legal_entity.dart';

import '../../modules/common_setup/legal_entity/presentation/controller/legal_entity_controller.dart';

import '../auth/bs_permission_provider.dart';

/// ---------------------------------------------------------------------------
/// All active Legal Entities allowed for the current user.
/// ---------------------------------------------------------------------------

final bsAllowedLegalEntitiesProvider =
    Provider<List<LegalEntity>>(
  (ref) {
    final user =
        ref.watch(
      bsCurrentUserProvider,
    );

    final legalEntityState =
        ref.watch(
      legalEntityControllerProvider,
    );

    return legalEntityState.maybeWhen(
      data: (
        legalEntities,
      ) {
        final allowedIds =
            user.allowedLegalEntityIds
                .toSet();

        return legalEntities
            .where(
              (entity) =>
                  entity.isActive &&
                  allowedIds.contains(
                    entity.id,
                  ),
            )
            .toList();
      },
      orElse: () {
        return <LegalEntity>[];
      },
    );
  },
);


final bsCurrentLegalEntityProvider =
    StateProvider<LegalEntity?>(
  (ref) {
    final allowedEntities =
        ref.watch(
      bsAllowedLegalEntitiesProvider,
    );

    final user =
        ref.watch(
      bsCurrentUserProvider,
    );

    if (allowedEntities.isEmpty) {
      return null;
    }

    final defaultId =
        user.defaultLegalEntityId;

    if (defaultId != null) {
      for (final entity
          in allowedEntities) {
        if (entity.id == defaultId) {
          return entity;
        }
      }
    }

    return allowedEntities.first;
  },
);