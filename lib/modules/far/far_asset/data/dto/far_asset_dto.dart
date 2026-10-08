import '../../domain/model/far_asset.dart';

class FarAssetDto {
  const FarAssetDto({
    required this.id,
    this.draftNo,
    this.status,
    this.source,
    this.draftDate,
    this.preparedBy,
    this.lastUpdated,

    required this.assetName,
    this.description,
    this.assetType,
    this.brand,
    this.model,
    this.serialNumber,
    this.quantity,
    this.unit,

    this.assetClass,
    this.assetCategory,
    this.subCategory,
    this.depreciationMethod,
    this.usefulLife,
    this.residualValue,

    this.company,
    this.branch,
    this.department,
    this.location,
    this.custodian,

    this.acquisitionDate,
    this.invoiceNo,
    this.supplier,
    this.purchaseCost,
    this.otherCapitalizableCost,
    this.totalCapitalizableCost,
    this.currency,
    this.capDate,
    this.glAssetAccount,
    this.accumDepreciationAccount,
    this.depreciationExpenseAccount,
    this.costCenter,

    this.invoiceAttachmentUrl,
    this.poAttachmentUrl,
    this.approvalReference,
    this.remarks,
  });

  final int id;
  final String? draftNo;
  final String? status;
  final String? source;
  final DateTime? draftDate;
  final String? preparedBy;
  final DateTime? lastUpdated;

  final String assetName;
  final String? description;
  final String? assetType;
  final String? brand;
  final String? model;
  final String? serialNumber;
  final double? quantity;
  final String? unit;

  final String? assetClass;
  final String? assetCategory;
  final String? subCategory;
  final String? depreciationMethod;
  final double? usefulLife;
  final double? residualValue;

  final int? company;
  final int? branch;
  final int? department;
  final int? location;
  final int? custodian;

  final DateTime? acquisitionDate;
  final String? invoiceNo;
  final int? supplier;
  final double? purchaseCost;
  final double? otherCapitalizableCost;
  final double? totalCapitalizableCost;
  final String? currency;
  final DateTime? capDate;
  final int? glAssetAccount;
  final int? accumDepreciationAccount;
  final int? depreciationExpenseAccount;
  final int? costCenter;

  final String? invoiceAttachmentUrl;
  final String? poAttachmentUrl;
  final String? approvalReference;
  final String? remarks;

  static int? _int(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static double? _double(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  factory FarAssetDto.fromJson(Map<String, dynamic> json) {
    return FarAssetDto(
      id: _int(json['id']) ?? 0,
      draftNo: json['draft_no']?.toString(),
      status: json['status']?.toString(),
      source: json['source']?.toString(),
      draftDate: _date(json['draft_date']),
      preparedBy: json['prepared_by']?.toString(),
      lastUpdated: _date(json['last_updated']),

      assetName: json['asset_name']?.toString() ?? '',
      description: json['description']?.toString(),
      assetType: json['asset_type']?.toString(),
      brand: json['brand']?.toString(),
      model: json['model']?.toString(),
      serialNumber: json['serial_number']?.toString(),
      quantity: _double(json['quantity']),
      unit: json['unit']?.toString(),

      assetClass: json['asset_class']?.toString(),
      assetCategory: json['asset_category']?.toString(),
      subCategory: json['sub_category']?.toString(),
      depreciationMethod: json['depreciation_method']?.toString(),
      usefulLife: _double(json['useful_life']),
      residualValue: _double(json['residual_value']),

      company: _int(json['company']),
      branch: _int(json['branch']),
      department: _int(json['department']),
      location: _int(json['location']),
      custodian: _int(json['custodian']),

      acquisitionDate: _date(json['acquisition_date']),
      invoiceNo: json['invoice_no']?.toString(),
      supplier: _int(json['supplier']),
      purchaseCost: _double(json['purchase_cost']),
      otherCapitalizableCost: _double(json['other_capitalizable_cost']),
      totalCapitalizableCost: _double(json['total_capitalizable_cost']),
      currency: json['currency']?.toString(),
      capDate: _date(json['cap_date']),
      glAssetAccount: _int(json['gl_asset_account']),
      accumDepreciationAccount: _int(json['accum_depreciation_account']),
      depreciationExpenseAccount: _int(json['depreciation_expense_account']),
      costCenter: _int(json['cost_center']),

      invoiceAttachmentUrl: json['invoice_attachment_url']?.toString(),
      poAttachmentUrl: json['po_attachment_url']?.toString(),
      approvalReference: json['approval_reference']?.toString(),
      remarks: json['remarks']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'draft_no': draftNo,
      'status': status,
      'source': source,
      'draft_date': draftDate?.toIso8601String(),
      'prepared_by': preparedBy,
      'last_updated': lastUpdated?.toIso8601String(),

      'asset_name': assetName,
      'description': description,
      'asset_type': assetType,
      'brand': brand,
      'model': model,
      'serial_number': serialNumber,
      'quantity': quantity,
      'unit': unit,

      'asset_class': assetClass,
      'asset_category': assetCategory,
      'sub_category': subCategory,
      'depreciation_method': depreciationMethod,
      'useful_life': usefulLife,
      'residual_value': residualValue,

      'company': company,
      'branch': branch,
      'department': department,
      'location': location,
      'custodian': custodian,

      'acquisition_date': acquisitionDate?.toIso8601String(),
      'invoice_no': invoiceNo,
      'supplier': supplier,
      'purchase_cost': purchaseCost,
      'other_capitalizable_cost': otherCapitalizableCost,
      'total_capitalizable_cost': totalCapitalizableCost,
      'currency': currency,
      'cap_date': capDate?.toIso8601String(),
      'gl_asset_account': glAssetAccount,
      'accum_depreciation_account': accumDepreciationAccount,
      'depreciation_expense_account': depreciationExpenseAccount,
      'cost_center': costCenter,

      'invoice_attachment_url': invoiceAttachmentUrl,
      'po_attachment_url': poAttachmentUrl,
      'approval_reference': approvalReference,
      'remarks': remarks,
    };
  }

  factory FarAssetDto.fromDomain(FarAsset a) {
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

  FarAsset toDomain() {
    return FarAsset(
      id: id,
      draftNo: draftNo,
      status: status,
      source: source,
      draftDate: draftDate,
      preparedBy: preparedBy,
      lastUpdated: lastUpdated,

      assetName: assetName,
      description: description,
      assetType: assetType,
      brand: brand,
      model: model,
      serial: serialNumber,
      quantity: quantity,
      unit: unit,

      assetClass: assetClass,
      assetCategory: assetCategory,
      subCategory: subCategory,
      depreciationMethod: depreciationMethod,
      useful: usefulLife,
      residual: residualValue,

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
      totalCapitalizableCost: totalCapitalizableCost,
      currency: currency,
      capDate: capDate,
      glAssetAccount: glAssetAccount,
      accumDepreciationAccount: accumDepreciationAccount,
      depreciationExpenseAccount: depreciationExpenseAccount,
      costCenter: costCenter,

      invoiceAttachment: invoiceAttachmentUrl,
      poAttachment: poAttachmentUrl,
      approvalReference: approvalReference,
      remarks: remarks,
    );
  }
}
