class FarAsset {
  const FarAsset({
    required this.id,

    this.draftNo,
    this.source,
    this.status,
    this.preparedBy,
    this.draftDate,
    this.lastUpdated,

    required this.assetName,
    this.description,
    this.assetType,
    this.brand,
    this.model,
    this.serial,
    this.quantity,
    this.unit,

    this.assetClass,
    this.assetCategory,
    this.subCategory,
    this.depreciationMethod,
    this.useful,
    this.residual,

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

    this.invoiceAttachment,
    this.poAttachment,
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
  final String? serial;
  final double? quantity;
  final String? unit;

  final String? assetClass;
  final String? assetCategory;
  final String? subCategory;
  final String? depreciationMethod;
  final double? useful;
  final double? residual;

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

  final String? invoiceAttachment;
  final String? poAttachment;
  final String? approvalReference;
  final String? remarks;
}
