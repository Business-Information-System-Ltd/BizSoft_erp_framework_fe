/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_file_download_service.dart
 Purpose      : Reusable file download service.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import 'dart:typed_data';

import '../../core/api/bs_api_client.dart';



class BsFileDownloadService {
  const BsFileDownloadService(
    this._client,
  );

  final BsApiClient _client;

  Future<Uint8List> download({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final bytes = await _client.getBytes(
      path,
      queryParameters: queryParameters,
    );

    if (bytes.isEmpty) {
      throw Exception(
        'Download failed: empty file response.',
      );
    }

    return Uint8List.fromList(bytes);
  }
}