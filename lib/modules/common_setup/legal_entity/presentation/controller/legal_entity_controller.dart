/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : legal_entity_controller.dart
 Purpose      : Legal Entity list controller.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/providers/bs_api_client_provider.dart';

import '../../data/repository/legal_entity_repository.dart';
import '../../data/service/legal_entity_api_service.dart';

import '../../domain/model/legal_entity.dart';

final legalEntityApiServiceProvider =
    Provider<LegalEntityApiService>(
  (ref) {
    return LegalEntityApiService(
      ref.watch(
        bsApiClientProvider,
      ),
    );
  },
);

final legalEntityRepositoryProvider =
    Provider<LegalEntityRepository>(
  (ref) {
    return LegalEntityRepository(
      ref.watch(
        legalEntityApiServiceProvider,
      ),
    );
  },
);

class LegalEntityController
    extends StateNotifier<
        AsyncValue<List<LegalEntity>>> {
  LegalEntityController(
    this._repository,
  ) : super(
          const AsyncValue.loading(),
        ) {
    load();
  }

  final LegalEntityRepository _repository;

  Future<void> load() async {
    state =
        const AsyncValue.loading();

    state = await AsyncValue.guard(
      () {
        return _repository
            .getLegalEntities();
      },
    );
  }

  Future<void> refresh() async {
    await load();
  }
}

final legalEntityControllerProvider =
    StateNotifierProvider<
        LegalEntityController,
        AsyncValue<List<LegalEntity>>>(
  (
    ref,
  ) {
    return LegalEntityController(
      ref.watch(
        legalEntityRepositoryProvider,
      ),
    );
  },
);