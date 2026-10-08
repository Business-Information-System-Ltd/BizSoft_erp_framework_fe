/*
===============================================================================
 BizSoft ERP - ERP Organization
===============================================================================

 File Name    : branch_export_service.dart
 Purpose      : Branch export service.
 Company      : BizSoft Systems
 Created By   : BizSoft Systems

===============================================================================
*/

import 'dart:typed_data';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../shared/services/bs_file_download_service.dart';

class BranchExportService {
  BranchExportService(
    BsApiClient client,
  ) : _downloadService = BsFileDownloadService(client);

  final BsFileDownloadService _downloadService;

  static const String _pdfPath =
      '/api/erp-organization/organization/branches/export/pdf/';

  Future<Uint8List> downloadPdf({
    int? legalEntityId,
    String? branchType,
    String? status,
    String? search,
  }) async {
    final queryParameters = <String, dynamic>{};
    if (legalEntityId !=
        null) {
      queryParameters[
        'legal_entity'
      ] = legalEntityId;
    }

    if (branchType != null &&
        branchType.trim().isNotEmpty) {
      queryParameters['branch_type'] =
          branchType.trim();
    }

    if (status != null &&
        status.trim().isNotEmpty) {
      queryParameters['is_active'] =
          status.trim();
    }

    if (search != null &&
        search.trim().isNotEmpty) {
      queryParameters['search'] =
          search.trim();
    }

    return _downloadService.download(
      path: _pdfPath,
      queryParameters: queryParameters,
    );
  }
}