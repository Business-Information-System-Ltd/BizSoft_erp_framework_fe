import 'dart:typed_data';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../shared/services/bs_file_download_service.dart';

class FarAssetExportService {
  FarAssetExportService(BsApiClient client)
    : _downloadService = BsFileDownloadService(client);

  final BsFileDownloadService _downloadService;

  static const String _pdfPath = '/api/erp-far/far/assets/export/pdf/';

  static const String _excelPath = '/api/erp-far/far/assets/export/excel/';

  static const String _csvPath = '/api/erp-far/far/assets/export/csv/';

  Map<String, dynamic> _buildQuery({
    String? status,
    String? assetType,
    String? search,
  }) {
    final queryParameters = <String, dynamic>{};

    if (status != null && status.trim().isNotEmpty) {
      queryParameters['status'] = status.trim();
    }

    if (assetType != null && assetType.trim().isNotEmpty) {
      queryParameters['asset_type'] = assetType.trim();
    }

    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }

    return queryParameters;
  }

  Future<Uint8List> downloadPdf({
    String? status,
    String? assetType,
    String? search,
  }) async {
    return _downloadService.download(
      path: _pdfPath,
      queryParameters: _buildQuery(
        status: status,
        assetType: assetType,
        search: search,
      ),
    );
  }

  Future<Uint8List> downloadExcel({
    String? status,
    String? assetType,
    String? search,
  }) async {
    return _downloadService.download(
      path: _excelPath,
      queryParameters: _buildQuery(
        status: status,
        assetType: assetType,
        search: search,
      ),
    );
  }

  Future<Uint8List> downloadCsv({
    String? status,
    String? assetType,
    String? search,
  }) async {
    return _downloadService.download(
      path: _csvPath,
      queryParameters: _buildQuery(
        status: status,
        assetType: assetType,
        search: search,
      ),
    );
  }
}
