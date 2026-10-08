class FarAssetUpdateRequestDto {
  const FarAssetUpdateRequestDto({
    required this.id,
    this.draftNo,
    this.status,
    this.source,
    this.draftDate,
    this.preparedBy,

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

  String? _dateOnly(DateTime? value) {
    if (value == null) {
      return null;
    }

    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'draft_no': draftNo,
      'status': status,
      'source': source,
      'draft_date': _dateOnly(draftDate),
      'prepared_by': preparedBy,

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

      'acquisition_date': _dateOnly(acquisitionDate),
      'invoice_no': invoiceNo,
      'supplier': supplier,
      'purchase_cost': purchaseCost,
      'other_capitalizable_cost': otherCapitalizableCost,
      'currency': currency,
      'cap_date': _dateOnly(capDate),
      'gl_asset_account': glAssetAccount,
      'accum_depreciation_account': accumDepreciationAccount,
      'depreciation_expense_account': depreciationExpenseAccount,
      'cost_center': costCenter,

      'approval_reference': approvalReference,
      'remarks': remarks,
    };
  }
}
