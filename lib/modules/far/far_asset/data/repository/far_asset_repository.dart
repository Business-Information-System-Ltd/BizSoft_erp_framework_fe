import '../../domain/model/far_asset.dart';
import '../dto/far_asset_create_request_dto.dart';
import '../dto/far_asset_update_request_dto.dart';
import '../mapper/far_asset_mapper.dart';
import '../service/far_asset_api_service.dart';

class FarAssetRepository {
  const FarAssetRepository(this._apiService);

  final FarAssetApiService _apiService;

  Future<List<FarAsset>> getFarAssets({
    String? status,
    String? assetType,
    String? search,
  }) async {
    final dtos = await _apiService.getFarAssets(
      status: status,
      assetType: assetType,
      search: search,
    );

    return dtos.map(FarAssetMapper.fromDto).toList();
  }

  Future<FarAsset> getFarAssetById(int id) async {
    final dto = await _apiService.getFarAssetById(id);

    return FarAssetMapper.fromDto(dto);
  }

  Future<FarAsset> createFarAsset({
    String? draftNo,
    String? status,
    String? source,
    DateTime? draftDate,
    String? preparedBy,
    required String assetName,
    String? description,
    String? assetType,
    String? brand,
    String? model,
    String? serial,
    double? quantity,
    String? unit,
    String? assetClass,
    String? assetCategory,
    String? subCategory,
    String? depreciationMethod,
    double? useful,
    double? residual,
    int? company,
    int? branch,
    int? department,
    int? location,
    int? custodian,
    DateTime? acquisitionDate,
    String? invoiceNo,
    int? supplier,
    double? purchaseCost,
    double? otherCapitalizableCost,
    String? currency,
    DateTime? capDate,
    int? glAssetAccount,
    int? accumDepreciationAccount,
    int? depreciationExpenseAccount,
    int? costCenter,
    String? invoiceAttachment,
    String? poAttachment,
    String? approvalReference,
    String? remarks,
  }) async {
    final dto = FarAssetCreateRequestDto(
      draftNo: draftNo,
      status: status,
      source: source,
      draftDate: draftDate,
      preparedBy: preparedBy,
      assetName: assetName,
      description: description,
      assetType: assetType,
      brand: brand,
      model: model,
      serialNumber: serial,
      quantity: quantity,
      unit: unit,
      assetClass: assetClass,
      assetCategory: assetCategory,
      subCategory: subCategory,
      depreciationMethod: depreciationMethod,
      usefulLife: useful,
      residualValue: residual,
      company: company,
      branch: branch,
      department: department,
      location: location,
      custodian: custodian,
      acquisitionDate: acquisitionDate,
      invoiceNo: invoiceNo,
      supplier: supplier,
      purchaseCost: purchaseCost,
      otherCapitalizableCost: otherCapitalizableCost,
      currency: currency,
      capDate: capDate,
      glAssetAccount: glAssetAccount,
      accumDepreciationAccount: accumDepreciationAccount,
      depreciationExpenseAccount: depreciationExpenseAccount,
      costCenter: costCenter,
      invoiceAttachment: invoiceAttachment,
      poAttachment: poAttachment,
      approvalReference: approvalReference,
      remarks: remarks,
    );

    final response = await _apiService.createFarAsset(dto);

    return FarAssetMapper.fromDto(response);
  }

  Future<FarAsset> updateFarAsset({
    required int id,
    String? draftNo,
    String? status,
    String? source,
    DateTime? draftDate,
    String? preparedBy,
    required String assetName,
    String? description,
    String? assetType,
    String? brand,
    String? model,
    String? serialNumber,
    double? quantity,
    String? unit,
    String? assetClass,
    String? assetCategory,
    String? subCategory,
    String? depreciationMethod,
    double? useful,
    double? residual,
    int? company,
    int? branch,
    int? department,
    int? location,
    int? custodian,
    DateTime? acquisitionDate,
    String? invoiceNo,
    int? supplier,
    double? purchaseCost,
    double? otherCapitalizableCost,
    String? currency,
    DateTime? capDate,
    int? glAssetAccount,
    int? accumDepreciationAccount,
    int? depreciationExpenseAccount,
    int? costCenter,
    String? invoiceAttachment,
    String? poAttachment,
    String? approvalReference,
    String? remarks,
  }) async {
    final dto = FarAssetUpdateRequestDto(
      id: id,
      draftNo: draftNo,
      status: status,
      source: source,
      draftDate: draftDate,
      preparedBy: preparedBy,
      assetName: assetName,
      description: description,
      assetType: assetType,
      brand: brand,
      model: model,
      serialNumber: serialNumber,
      quantity: quantity,
      unit: unit,
      assetClass: assetClass,
      assetCategory: assetCategory,
      subCategory: subCategory,
      depreciationMethod: depreciationMethod,
      usefulLife: useful,
      residualValue: residual,
      company: company,
      branch: branch,
      department: department,
      location: location,
      custodian: custodian,
      acquisitionDate: acquisitionDate,
      invoiceNo: invoiceNo,
      supplier: supplier,
      purchaseCost: purchaseCost,
      otherCapitalizableCost: otherCapitalizableCost,
      currency: currency,
      capDate: capDate,
      glAssetAccount: glAssetAccount,
      accumDepreciationAccount: accumDepreciationAccount,
      depreciationExpenseAccount: depreciationExpenseAccount,
      costCenter: costCenter,
      invoiceAttachment: invoiceAttachment,
      poAttachment: poAttachment,
      approvalReference: approvalReference,
      remarks: remarks,
    );

    final response = await _apiService.updateFarAsset(id, dto);

    return FarAssetMapper.fromDto(response);
  }

  Future<void> deleteFarAsset(int id) {
    return _apiService.deleteFarAsset(id);
  }
}
