import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';
import '../../../../../core/providers/bs_api_client_provider.dart';
import '../../data/dto/far_asset_create_request_dto.dart';
import '../../data/repository/far_asset_repository.dart';
import '../../data/service/far_asset_api_service.dart';

class AdditionalCostItem {
  final String costType;
  final double purchaseCost;
  final double otherCapitalizableCost;
  final double amount;
  final String currency;
  final String description;
  final DateTime? date;

  AdditionalCostItem({
    required this.costType,
    required this.purchaseCost,
    required this.otherCapitalizableCost,
    required this.currency,
    required this.description,
    this.date,
  }) : amount = purchaseCost + otherCapitalizableCost;

  Map<String, dynamic> toJson() => {
    'costType': costType,
    'purchaseCost': purchaseCost,
    'otherCapitalizableCost': otherCapitalizableCost,
    'amount': amount,
    'currency': currency,
    'description': description,
    'date': date?.toIso8601String(),
  };
}

final farAssetFormControllerProvider =
    StateNotifierProvider.family<
      FarAssetFormController,
      FarAssetFormState,
      int?
    >((ref, assetId) {
      final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);

      return FarAssetFormController(
        repository: FarAssetRepository(
          FarAssetApiService(ref.watch(bsApiClientProvider)),
        ),
        assetId: assetId,
        currentLegalEntityId: currentLegalEntity?.id,
      );
    });

class FarAssetFormState {
  const FarAssetFormState({
    this.assetId,
    this.legalEntityId,

    this.draftNo = 'DRAFT-000001',
    this.status = 'Draft',
    this.source = 'Manual',
    this.draftDate,
    this.preparedBy = 'User Name',
    this.lastUpdated,

    this.assetName = '',
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

    this.additionalCosts = const <AdditionalCostItem>[],

    this.validationStatus = 'Incomplete',
    this.validationMessages = const <String>[],

    this.loading = false,
    this.saving = false,
    this.isDirty = false,
    this.error,
    this.loadVersion = 0,
  });

  final int? assetId;
  final int? legalEntityId;

  final String draftNo;
  final String status;
  final String source;
  final DateTime? draftDate;
  final String preparedBy;
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

  double get totalCapitalizableCost =>
      (purchaseCost ?? 0.0) + (otherCapitalizableCost ?? 0.0);

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

  final List<AdditionalCostItem> additionalCosts;

  final String validationStatus;
  final List<String> validationMessages;

  final bool loading;
  final bool saving;
  final bool isDirty;
  final String? error;
  final int loadVersion;

  static const Object _unset = Object();

  FarAssetFormState copyWith({
    int? assetId,
    int? legalEntityId,

    String? draftNo,
    String? status,
    String? source,
    Object? draftDate = _unset,
    String? preparedBy,
    Object? lastUpdated = _unset,

    String? assetName,
    Object? description = _unset,
    Object? assetType = _unset,
    Object? brand = _unset,
    Object? model = _unset,
    Object? serialNumber = _unset,
    Object? quantity = _unset,
    Object? unit = _unset,

    Object? assetClass = _unset,
    Object? assetCategory = _unset,
    Object? subCategory = _unset,
    Object? depreciationMethod = _unset,
    Object? usefulLife = _unset,
    Object? residualValue = _unset,

    Object? company = _unset,
    Object? branch = _unset,
    Object? department = _unset,
    Object? location = _unset,
    Object? custodian = _unset,

    Object? acquisitionDate = _unset,
    Object? invoiceNo = _unset,
    Object? supplier = _unset,
    Object? purchaseCost = _unset,
    Object? otherCapitalizableCost = _unset,
    Object? currency = _unset,
    Object? capDate = _unset,
    Object? glAssetAccount = _unset,
    Object? accumDepreciationAccount = _unset,
    Object? depreciationExpenseAccount = _unset,
    Object? costCenter = _unset,

    Object? invoiceAttachment = _unset,
    Object? poAttachment = _unset,

    Object? approvalReference = _unset,
    Object? remarks = _unset,

    List<AdditionalCostItem>? additionalCosts,

    String? validationStatus,
    List<String>? validationMessages,

    bool? loading,
    bool? saving,
    bool? isDirty,
    String? error,
    bool clearError = false,
    int? loadVersion,
  }) {
    return FarAssetFormState(
      assetId: assetId ?? this.assetId,
      legalEntityId: legalEntityId ?? this.legalEntityId,

      draftNo: draftNo ?? this.draftNo,
      status: status ?? this.status,
      source: source ?? this.source,
      draftDate: draftDate == _unset ? this.draftDate : draftDate as DateTime?,
      preparedBy: preparedBy ?? this.preparedBy,
      lastUpdated: lastUpdated == _unset
          ? this.lastUpdated
          : lastUpdated as DateTime?,

      assetName: assetName ?? this.assetName,
      description: description == _unset
          ? this.description
          : description as String?,
      assetType: assetType == _unset ? this.assetType : assetType as String?,
      brand: brand == _unset ? this.brand : brand as String?,
      model: model == _unset ? this.model : model as String?,
      serialNumber: serialNumber == _unset
          ? this.serialNumber
          : serialNumber as String?,
      quantity: quantity == _unset ? this.quantity : quantity as double?,
      unit: unit == _unset ? this.unit : unit as String?,

      assetClass: assetClass == _unset
          ? this.assetClass
          : assetClass as String?,
      assetCategory: assetCategory == _unset
          ? this.assetCategory
          : assetCategory as String?,
      subCategory: subCategory == _unset
          ? this.subCategory
          : subCategory as String?,
      depreciationMethod: depreciationMethod == _unset
          ? this.depreciationMethod
          : depreciationMethod as String?,
      usefulLife: usefulLife == _unset
          ? this.usefulLife
          : usefulLife as double?,
      residualValue: residualValue == _unset
          ? this.residualValue
          : residualValue as double?,

      company: company == _unset ? this.company : company as int?,
      branch: branch == _unset ? this.branch : branch as int?,
      department: department == _unset ? this.department : department as int?,
      location: location == _unset ? this.location : location as int?,
      custodian: custodian == _unset ? this.custodian : custodian as int?,

      acquisitionDate: acquisitionDate == _unset
          ? this.acquisitionDate
          : acquisitionDate as DateTime?,
      invoiceNo: invoiceNo == _unset ? this.invoiceNo : invoiceNo as String?,
      supplier: supplier == _unset ? this.supplier : supplier as int?,
      purchaseCost: purchaseCost == _unset
          ? this.purchaseCost
          : purchaseCost as double?,
      otherCapitalizableCost: otherCapitalizableCost == _unset
          ? this.otherCapitalizableCost
          : otherCapitalizableCost as double?,
      currency: currency == _unset ? this.currency : currency as String?,
      capDate: capDate == _unset ? this.capDate : capDate as DateTime?,
      glAssetAccount: glAssetAccount == _unset
          ? this.glAssetAccount
          : glAssetAccount as int?,
      accumDepreciationAccount: accumDepreciationAccount == _unset
          ? this.accumDepreciationAccount
          : accumDepreciationAccount as int?,
      depreciationExpenseAccount: depreciationExpenseAccount == _unset
          ? this.depreciationExpenseAccount
          : depreciationExpenseAccount as int?,
      costCenter: costCenter == _unset ? this.costCenter : costCenter as int?,

      invoiceAttachment: invoiceAttachment == _unset
          ? this.invoiceAttachment
          : invoiceAttachment as String?,
      poAttachment: poAttachment == _unset
          ? this.poAttachment
          : poAttachment as String?,

      approvalReference: approvalReference == _unset
          ? this.approvalReference
          : approvalReference as String?,
      remarks: remarks == _unset ? this.remarks : remarks as String?,

      additionalCosts: additionalCosts ?? this.additionalCosts,

      validationStatus: validationStatus ?? this.validationStatus,
      validationMessages: validationMessages ?? this.validationMessages,

      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      isDirty: isDirty ?? this.isDirty,
      error: clearError ? null : (error ?? this.error),
      loadVersion: loadVersion ?? this.loadVersion,
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CONTROLLER
// ═══════════════════════════════════════════════════════════════
class FarAssetFormController extends StateNotifier<FarAssetFormState> {
  FarAssetFormController({
    required FarAssetRepository repository,
    required int? assetId,
    required int? currentLegalEntityId,
  }) : _repository = repository,
       _assetId = assetId,
       super(
         FarAssetFormState(
           assetId: assetId,
           legalEntityId: currentLegalEntityId,
           draftDate: DateTime.now(),
           lastUpdated: DateTime.now(),
           loading: assetId != null,
         ),
       ) {
    if (assetId != null) {
      _loadAsset(assetId);
    }
  }

  final FarAssetRepository _repository;
  final int? _assetId;

  Future<void> _loadAsset(int id) async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      state = state.copyWith(loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: 'Failed to load asset: $e');
    }
  }

  void updateField({
    String? assetName,
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
    double? usefulLife,
    double? residualValue,
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
  }) {
    state = state.copyWith(
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
      usefulLife: usefulLife,
      residualValue: residualValue,
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
      lastUpdated: DateTime.now(),
      isDirty: true,
      clearError: true,
    );
  }

  void updateAssetName(String v) => updateField(assetName: v);
  void updateDescription(String v) => updateField(description: v);
  void updateBrand(String v) => updateField(brand: v);
  void updateModel(String v) => updateField(model: v);
  void updateSerialNumber(String v) => updateField(serialNumber: v);
  void updateAssetType(String? v) => updateField(assetType: v);
  void updateAssetClass(String? v) => updateField(assetClass: v);
  void updateAssetCategory(String? v) => updateField(assetCategory: v);
  void updateSubCategory(String? v) => updateField(subCategory: v);
  void updateDepreciationMethod(String? v) =>
      updateField(depreciationMethod: v);
  void updateUsefulLife(double? v) => updateField(usefulLife: v);
  void updateResidualValue(double? v) => updateField(residualValue: v);
  void updateCompany(int? v) => updateField(company: v);
  void updateBranch(int? v) => updateField(branch: v);
  void updateDepartment(int? v) => updateField(department: v);
  void updateLocation(int? v) => updateField(location: v);
  void updateCustodian(int? v) => updateField(custodian: v);
  void updateSupplier(int? v) => updateField(supplier: v);
  void updateInvoiceNo(String v) => updateField(invoiceNo: v);
  void updateAcquisitionDate(DateTime? v) => updateField(acquisitionDate: v);
  void updateCapDate(DateTime? v) => updateField(capDate: v);
  void updateGlAssetAccount(int? v) => updateField(glAssetAccount: v);
  void updateAccumDepreciationAccount(int? v) =>
      updateField(accumDepreciationAccount: v);
  void updateDepreciationExpenseAccount(int? v) =>
      updateField(depreciationExpenseAccount: v);
  void updateCostCenter(int? v) => updateField(costCenter: v);
  void updateApprovalReference(String v) => updateField(approvalReference: v);
  void updateRemarks(String v) => updateField(remarks: v);
  void updateInvoiceAttachment(String? v) => updateField(invoiceAttachment: v);
  void updatePoAttachment(String? v) => updateField(poAttachment: v);

  void addAdditionalCostItem(AdditionalCostItem item) {
    final updated = [...state.additionalCosts, item];
    final newOtherCost = updated.fold<double>(0, (s, e) => s + e.amount);

    state = state.copyWith(
      additionalCosts: updated,
      otherCapitalizableCost: newOtherCost,
      lastUpdated: DateTime.now(),
      isDirty: true,
    );
  }

  void removeAdditionalCostItem(int index) {
    if (index < 0 || index >= state.additionalCosts.length) return;

    final updated = [...state.additionalCosts]..removeAt(index);
    final newOtherCost = updated.fold<double>(0, (s, e) => s + e.amount);

    state = state.copyWith(
      additionalCosts: updated,
      otherCapitalizableCost: newOtherCost,
      lastUpdated: DateTime.now(),
      isDirty: true,
    );
  }

  bool validateForm() {
    final messages = <String>[];

    if (state.assetName.trim().isEmpty) {
      messages.add('Asset Name is required.');
    }
    if (state.usefulLife == null || state.usefulLife! <= 0) {
      messages.add('Useful life is required before capitalization.');
    }
    if (state.glAssetAccount == null) {
      messages.add('GL asset account is missing.');
    }
    if (state.totalCapitalizableCost <= 0) {
      messages.add('Total Capitalizable Cost must be greater than zero.');
    }

    final valStatus = messages.isEmpty ? 'Complete' : 'Error';

    state = state.copyWith(
      validationStatus: valStatus,
      validationMessages: messages,
    );

    return messages.isEmpty;
  }

  FarAssetCreateRequestDto toDto() {
    return FarAssetCreateRequestDto(
      draftNo: state.draftNo,
      status: state.status,
      source: state.source,
      draftDate: state.draftDate,
      preparedBy: state.preparedBy,
      assetName: state.assetName,
      description: state.description,
      assetType: state.assetType,
      brand: state.brand,
      model: state.model,
      serialNumber: state.serialNumber,
      quantity: state.quantity,
      unit: state.unit,
      assetClass: state.assetClass,
      assetCategory: state.assetCategory,
      subCategory: state.subCategory,
      depreciationMethod: state.depreciationMethod,
      usefulLife: state.usefulLife,
      residualValue: state.residualValue,
      company: state.company,
      branch: state.branch,
      department: state.department,
      location: state.location,
      custodian: state.custodian,
      acquisitionDate: state.acquisitionDate,
      invoiceNo: state.invoiceNo,
      supplier: state.supplier,
      purchaseCost: state.purchaseCost,
      otherCapitalizableCost: state.otherCapitalizableCost,
      currency: state.currency,
      capDate: state.capDate,
      glAssetAccount: state.glAssetAccount,
      accumDepreciationAccount: state.accumDepreciationAccount,
      depreciationExpenseAccount: state.depreciationExpenseAccount,
      costCenter: state.costCenter,
      invoiceAttachment: state.invoiceAttachment,
      poAttachment: state.poAttachment,
      approvalReference: state.approvalReference,
      remarks: state.remarks,
    );
  }

  Future<void> saveDraft() async {
    if (!validateForm()) return;

    state = state.copyWith(saving: true, clearError: true);
    try {
      final requestDto = toDto();

      final saved = await _repository.createFarAsset(
        draftNo: requestDto.draftNo,
        status: requestDto.status,
        source: requestDto.source,
        draftDate: requestDto.draftDate,
        preparedBy: requestDto.preparedBy,
        assetName: requestDto.assetName,
        description: requestDto.description,
        assetType: requestDto.assetType,
        brand: requestDto.brand,
        model: requestDto.model,
        serial: requestDto.serialNumber,
        quantity: requestDto.quantity,
        unit: requestDto.unit,
        assetClass: requestDto.assetClass,
        assetCategory: requestDto.assetCategory,
        subCategory: requestDto.subCategory,
        depreciationMethod: requestDto.depreciationMethod,
        useful: requestDto.usefulLife,
        residual: requestDto.residualValue,
        company: requestDto.company,
        branch: requestDto.branch,
        department: requestDto.department,
        location: requestDto.location,
        custodian: requestDto.custodian,
        acquisitionDate: requestDto.acquisitionDate,
        invoiceNo: requestDto.invoiceNo,
        supplier: requestDto.supplier,
        purchaseCost: requestDto.purchaseCost,
        otherCapitalizableCost: requestDto.otherCapitalizableCost,
        currency: requestDto.currency,
        capDate: requestDto.capDate,
        glAssetAccount: requestDto.glAssetAccount,
        accumDepreciationAccount: requestDto.accumDepreciationAccount,
        depreciationExpenseAccount: requestDto.depreciationExpenseAccount,
        costCenter: requestDto.costCenter,
        invoiceAttachment: requestDto.invoiceAttachment,
        poAttachment: requestDto.poAttachment,
        approvalReference: requestDto.approvalReference,
        remarks: requestDto.remarks,
      );

      state = state.copyWith(
        saving: false,
        assetId: saved.id,
        status: 'Draft',
        lastUpdated: DateTime.now(),
        isDirty: false,
      );
    } catch (e) {
      state = state.copyWith(saving: false, error: 'Failed to save draft: $e');
    }
  }

  Future<void> save() async {
    if (!validateForm()) return;

    state = state.copyWith(saving: true, clearError: true);
    try {
      final requestDto = toDto();

      if (state.assetId == null) {
        final saved = await _repository.createFarAsset(
          draftNo: requestDto.draftNo,
          status: requestDto.status,
          source: requestDto.source,
          draftDate: requestDto.draftDate,
          preparedBy: requestDto.preparedBy,
          assetName: requestDto.assetName,
          description: requestDto.description,
          assetType: requestDto.assetType,
          brand: requestDto.brand,
          model: requestDto.model,
          serial: requestDto.serialNumber,
          quantity: requestDto.quantity,
          unit: requestDto.unit,
          assetClass: requestDto.assetClass,
          assetCategory: requestDto.assetCategory,
          subCategory: requestDto.subCategory,
          depreciationMethod: requestDto.depreciationMethod,
          useful: requestDto.usefulLife,
          residual: requestDto.residualValue,
          company: requestDto.company,
          branch: requestDto.branch,
          department: requestDto.department,
          location: requestDto.location,
          custodian: requestDto.custodian,
          acquisitionDate: requestDto.acquisitionDate,
          invoiceNo: requestDto.invoiceNo,
          supplier: requestDto.supplier,
          purchaseCost: requestDto.purchaseCost,
          otherCapitalizableCost: requestDto.otherCapitalizableCost,
          currency: requestDto.currency,
          capDate: requestDto.capDate,
          glAssetAccount: requestDto.glAssetAccount,
          accumDepreciationAccount: requestDto.accumDepreciationAccount,
          depreciationExpenseAccount: requestDto.depreciationExpenseAccount,
          costCenter: requestDto.costCenter,
          invoiceAttachment: requestDto.invoiceAttachment,
          poAttachment: requestDto.poAttachment,
          approvalReference: requestDto.approvalReference,
          remarks: requestDto.remarks,
        );
        state = state.copyWith(assetId: saved.id);
      } else {
        await _repository.updateFarAsset(
          id: state.assetId!,
          draftNo: requestDto.draftNo,
          status: requestDto.status,
          source: requestDto.source,
          draftDate: requestDto.draftDate,
          preparedBy: requestDto.preparedBy,
          assetName: requestDto.assetName,
          description: requestDto.description,
          assetType: requestDto.assetType,
          brand: requestDto.brand,
          model: requestDto.model,
          serialNumber: requestDto.serialNumber,
          quantity: requestDto.quantity,
          unit: requestDto.unit,
          assetClass: requestDto.assetClass,
          assetCategory: requestDto.assetCategory,
          subCategory: requestDto.subCategory,
          depreciationMethod: requestDto.depreciationMethod,
          useful: requestDto.usefulLife,
          residual: requestDto.residualValue,
          company: requestDto.company,
          branch: requestDto.branch,
          department: requestDto.department,
          location: requestDto.location,
          custodian: requestDto.custodian,
          acquisitionDate: requestDto.acquisitionDate,
          invoiceNo: requestDto.invoiceNo,
          supplier: requestDto.supplier,
          purchaseCost: requestDto.purchaseCost,
          otherCapitalizableCost: requestDto.otherCapitalizableCost,
          currency: requestDto.currency,
          capDate: requestDto.capDate,
          glAssetAccount: requestDto.glAssetAccount,
          accumDepreciationAccount: requestDto.accumDepreciationAccount,
          depreciationExpenseAccount: requestDto.depreciationExpenseAccount,
          costCenter: requestDto.costCenter,
          invoiceAttachment: requestDto.invoiceAttachment,
          poAttachment: requestDto.poAttachment,
          approvalReference: requestDto.approvalReference,
          remarks: requestDto.remarks,
        );
      }

      state = state.copyWith(
        saving: false,
        lastUpdated: DateTime.now(),
        isDirty: false,
      );
    } catch (e) {
      state = state.copyWith(saving: false, error: 'Failed to save asset: $e');
    }
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}
