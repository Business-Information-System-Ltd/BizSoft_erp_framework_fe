
import 'bs_api_client.dart';

class BsCrudApiService {
  const BsCrudApiService({
    required BsApiClient client,
    required String basePath,
  }) : _client = client,
       _basePath = basePath;

  final BsApiClient _client;
  final String _basePath;

  Future<Map<String, dynamic>> list({
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = await _client.get(
      _collectionPath,
      queryParameters: _cleanQueryParameters(queryParameters),
    );
    return _normalizeListResponse(data);
  }

  Future<Map<String, dynamic>> getById(Object id) async {
    final data = await _client.get(_detailPath(id));
    return _asMap(data);
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final response = await _client.post(_collectionPath, data: data);
    return _asMap(response);
  }

  Future<Map<String, dynamic>> update(
    Object id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(_detailPath(id), data: data);
    return _asMap(response);
  }

  Future<Map<String, dynamic>> patch(
    Object id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.patch(_detailPath(id), data: data);
    return _asMap(response);
  }

  Future<void> delete(Object id) async {
    await _client.delete(_detailPath(id));
  }

  Future<Map<String, dynamic>> action(Object id, String actionName) async {
    final response = await _client.post(
      _nestedPath(_detailPath(id), actionName),
    );
    return _asMap(response);
  }

  Future<List<Map<String, dynamic>>> listChildRecords(
    Object parentId,
    String childName, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final data = await _client.get(
      _nestedPath(_detailPath(parentId), childName),
      queryParameters: _cleanQueryParameters(queryParameters),
    );
    return _extractResults(data);
  }

  Future<Map<String, dynamic>> createChildRecord(
    Object parentId,
    String childName,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post(
      _nestedPath(_detailPath(parentId), childName),
      data: data,
    );
    return _asMap(response);
  }

  Future<Map<String, dynamic>> updateChildRecord(
    Object parentId,
    String childName,
    Object childId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put(
      _nestedPath(_nestedPath(_detailPath(parentId), childName), '$childId'),
      data: data,
    );
    return _asMap(response);
  }

  Future<void> deleteChildRecord(
    Object parentId,
    String childName,
    Object childId,
  ) async {
    await _client.delete(
      _nestedPath(_nestedPath(_detailPath(parentId), childName), '$childId'),
    );
  }

  String get _collectionPath => _ensureTrailingSlash(_basePath);

  String _detailPath(Object id) {
    return _nestedPath(_collectionPath, Uri.encodeComponent('$id'));
  }

  String _nestedPath(String parentPath, String childName) {
    final parent = _ensureTrailingSlash(parentPath);
    final child = childName.trim().replaceAll(RegExp(r'^/+|/+$'), '');
    return _ensureTrailingSlash('$parent$child');
  }

  String _ensureTrailingSlash(String path) {
    return path.endsWith('/') ? path : '$path/';
  }

  Map<String, dynamic>? _cleanQueryParameters(
    Map<String, dynamic>? queryParameters,
  ) {
    if (queryParameters == null || queryParameters.isEmpty) {
      return null;
    }

    final cleaned = <String, dynamic>{};
    for (final entry in queryParameters.entries) {
      final value = entry.value;
      if (value == null) {
        continue;
      }
      if (value is String) {
        final trimmed = value.trim();
        if (trimmed.isEmpty) {
          continue;
        }
        cleaned[entry.key] = trimmed;
        continue;
      }
      if (value is Iterable && value.isEmpty) {
        continue;
      }
      if (value is Map && value.isEmpty) {
        continue;
      }
      cleaned[entry.key] = value;
    }

    return cleaned.isEmpty ? null : cleaned;
  }

  Map<String, dynamic> _normalizeListResponse(dynamic data) {
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      if (map['results'] is List) {
        return map;
      }
      if (map['items'] is List) {
        return map;
      }
      return {
        ...map,
        'results': _extractResults(data),
        'count': map['count'] ?? _extractResults(data).length,
        'next': map['next'],
        'previous': map['previous'],
      };
    }

    final results = _extractResults(data);
    return <String, dynamic>{
      'results': results,
      'count': results.length,
      'next': null,
      'previous': null,
    };
  }

  List<Map<String, dynamic>> _extractResults(dynamic data) {
    final rawItems = data is Map && data['results'] is List
        ? data['results'] as List
        : data is Map && data['items'] is List
        ? data['items'] as List
        : data is List
        ? data
        : const <dynamic>[];

    return rawItems
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data == null) {
      return <String, dynamic>{};
    }
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return <String, dynamic>{'value': data};
  }
}
