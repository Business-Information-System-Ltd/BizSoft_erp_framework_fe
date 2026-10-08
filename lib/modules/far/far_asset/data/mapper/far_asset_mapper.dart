import '../../domain/model/far_asset.dart';
import '../dto/far_asset_dto.dart';

class FarAssetMapper {
  const FarAssetMapper._();

  static FarAsset fromDto(FarAssetDto dto) {
    return FarAsset(
      id: dto.id,

      draftNo: dto.draftNo,
      status: dto.status,
      source: dto.source,
      draftDate: dto.draftDate,
      preparedBy: dto.preparedBy,
      lastUpdated: dto.lastUpdated,

      assetName: dto.assetName,
      description: dto.description,
      assetType: dto.assetType,
      brand: dto.brand,
      model: dto.model,
      serial: dto.serialNumber,
      quantity: dto.quantity,
      unit: dto.unit,

      assetClass: dto.assetClass,
      assetCategory: dto.assetCategory,
      subCategory: dto.subCategory,
      depreciationMethod: dto.depreciationMethod,
      useful: dto.usefulLife,
      residual: dto.residualValue,

      company: dto.company,
      branch: dto.branch,
      department: dto.department,
      location: dto.location,
      custodian: dto.custodian,

      acquisitionDate: dto.acquisitionDate,
      invoiceNo: dto.invoiceNo,
      supplier: dto.supplier,
      purchaseCost: dto.purchaseCost,
      otherCapitalizableCost: dto.otherCapitalizableCost,
      totalCapitalizableCost: dto.totalCapitalizableCost,
      currency: dto.currency,
      capDate: dto.capDate,
      glAssetAccount: dto.glAssetAccount,
      accumDepreciationAccount: dto.accumDepreciationAccount,
      depreciationExpenseAccount: dto.depreciationExpenseAccount,
      costCenter: dto.costCenter,

      invoiceAttachment: dto.invoiceAttachmentUrl,
      poAttachment: dto.poAttachmentUrl,
      approvalReference: dto.approvalReference,
      remarks: dto.remarks,
    );
  }

  static FarAssetDto toDto(FarAsset a) {
    return FarAssetDto(
      id: a.id,

      draftNo: a.draftNo,
      status: a.status,
      source: a.source,
      draftDate: a.draftDate,
      preparedBy: a.preparedBy,
      lastUpdated: a.lastUpdated,

      assetName: a.assetName,
      description: a.description,
      assetType: a.assetType,
      brand: a.brand,
      model: a.model,
      serialNumber: a.serial,
      quantity: a.quantity,
      unit: a.unit,

      assetClass: a.assetClass,
      assetCategory: a.assetCategory,
      subCategory: a.subCategory,
      depreciationMethod: a.depreciationMethod,
      usefulLife: a.useful,
      residualValue: a.residual,

      company: a.company,
      branch: a.branch,
      department: a.department,
      location: a.location,
      custodian: a.custodian,

      acquisitionDate: a.acquisitionDate,
      invoiceNo: a.invoiceNo,
      supplier: a.supplier,
      purchaseCost: a.purchaseCost,
      otherCapitalizableCost: a.otherCapitalizableCost,
      totalCapitalizableCost: a.totalCapitalizableCost,
      currency: a.currency,
      capDate: a.capDate,
      glAssetAccount: a.glAssetAccount,
      accumDepreciationAccount: a.accumDepreciationAccount,
      depreciationExpenseAccount: a.depreciationExpenseAccount,
      costCenter: a.costCenter,

      invoiceAttachmentUrl: a.invoiceAttachment,
      poAttachmentUrl: a.poAttachment,
      approvalReference: a.approvalReference,
      remarks: a.remarks,
    );
  }

  static FarAsset fromJson(Map<String, dynamic> json) {
    return fromDto(FarAssetDto.fromJson(json));
  }

  static List<FarAsset> fromDtoList(List<FarAssetDto> dtos) {
    return dtos.map(fromDto).toList();
  }

  static List<FarAsset> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((e) => FarAssetDto.fromJson(e as Map<String, dynamic>))
        .map(fromDto)
        .toList();
  }
}
