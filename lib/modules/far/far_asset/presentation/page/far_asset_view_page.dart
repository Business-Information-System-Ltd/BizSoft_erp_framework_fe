import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:bizsoft_frontend_framework/shared/buttons/bs_cancel_button.dart';

import '../../../../../shared/feedback/bs_error_state.dart';
import '../../../../../shared/feedback/bs_loading_overlay.dart';
import '../../../../../shared/layout/bs_detail_area.dart';
import '../../../../../shared/layout/bs_form_row.dart';
import '../../../../../shared/layout/bs_page.dart';
import '../../../../../shared/layout/bs_page_header.dart';
import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';
import '../../../../../shared/status/bs_status_badge.dart';

import '../../domain/model/far_asset.dart';
import '../controller/far_asset_view_controller.dart';

class FarAssetViewPage extends ConsumerWidget {
  const FarAssetViewPage({super.key, required this.assetId});

  final int assetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(farAssetViewControllerProvider(assetId));

    return BsPage(
      title: 'Fixed Asset Detail View',

      breadcrumb: const BsBreadcrumb(
        items: [
          BsBreadcrumbItem(label: 'Home', routePath: '/'),
          BsBreadcrumbItem(label: 'Fixed Asset Register'),
          BsBreadcrumbItem(label: 'Fixed Asset', routePath: '/far/far-assets'),
          BsBreadcrumbItem(label: 'View'),
        ],
      ),

      header: BsPageHeader(
        title: 'Fixed Asset Detail View',
        actions: [
          BsCancelButton(
            onPressed: () {
              context.go('/far/far-assets');
            },
          ),
        ],
      ),

      body: state.when(
        loading: () {
          return const BsLoadingOverlay(
            isLoading: true,
            child: SizedBox.expand(),
          );
        },

        error: (error, stackTrace) {
          return BsErrorState(
            message: error.toString(),
            onRetry: () {
              ref
                  .read(farAssetViewControllerProvider(assetId).notifier)
                  .refresh();
            },
          );
        },

        data: (asset) {
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              _FarAssetSummary(asset: asset),

              const SizedBox(height: 12),

              _buildBasicInformation(context, asset),

              const SizedBox(height: 12),

              _buildAssetDetails(context, asset),

              const SizedBox(height: 12),

              _buildClassification(context, asset),

              const SizedBox(height: 12),

              _buildDepreciation(context, asset),

              const SizedBox(height: 12),

              _buildOrganization(context, asset),

              const SizedBox(height: 12),

              _buildAcquisition(context, asset),

              const SizedBox(height: 12),

              _buildAccounting(context, asset),

              const SizedBox(height: 12),

              _buildDocuments(context, asset),

              const SizedBox(height: 12),

              _buildStatus(context, asset),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBasicInformation(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'BASIC INFORMATION',
      icon: Icons.info_outline,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(label: 'Draft No', value: asset.draftNo),
            _DetailItem(label: 'Asset Name', value: asset.assetName),
            _DetailItem(label: 'Source', value: asset.source),
            _DetailItem(label: 'Asset Type', value: asset.assetType),
            _DetailItem(label: 'Prepared By', value: asset.preparedBy),
            _DetailItem(
              label: 'Draft Date',
              value: _formatDate(asset.draftDate),
            ),
            _DetailItem(
              label: 'Last Updated',
              value: _formatDateTime(asset.lastUpdated),
            ),
            _DetailItem(label: 'Description', value: asset.description),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetDetails(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'ASSET DETAILS',
      icon: Icons.inventory_2_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(label: 'Asset Name', value: asset.assetName),
            _DetailItem(label: 'Brand', value: asset.brand),
            _DetailItem(label: 'Model', value: asset.model),
            _DetailItem(label: 'Serial Number', value: asset.serial),
            _DetailItem(label: 'Quantity', value: _formatValue(asset.quantity)),
            _DetailItem(label: 'Unit', value: asset.unit),
          ],
        ),
      ),
    );
  }

  Widget _buildClassification(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'CLASSIFICATION',
      icon: Icons.category_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(label: 'Asset Class', value: asset.assetClass),
            _DetailItem(label: 'Asset Category', value: asset.assetCategory),
            _DetailItem(label: 'Sub Category', value: asset.subCategory),
          ],
        ),
      ),
    );
  }

  Widget _buildDepreciation(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'DEPRECIATION',
      icon: Icons.trending_down_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(
              label: 'Depreciation Method',
              value: asset.depreciationMethod,
            ),
            _DetailItem(
              label: 'Useful Life',
              value: _formatValue(asset.useful),
            ),
            _DetailItem(
              label: 'Residual Value',
              value: _formatValue(asset.residual),
            ),
            _DetailItem(
              label: 'Capitalization Date',
              value: _formatDate(asset.capDate),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganization(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'ORGANIZATION',
      icon: Icons.business_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(label: 'Company', value: _objectValue(asset.company)),
            _DetailItem(label: 'Branch', value: _objectValue(asset.branch)),
            _DetailItem(
              label: 'Department',
              value: _objectValue(asset.department),
            ),
            _DetailItem(label: 'Location', value: _objectValue(asset.location)),
            _DetailItem(
              label: 'Custodian',
              value: _objectValue(asset.custodian),
            ),
            _DetailItem(
              label: 'Cost Center',
              value: _objectValue(asset.costCenter),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcquisition(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'ACQUISITION',
      icon: Icons.shopping_cart_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(
              label: 'Acquisition Date',
              value: _formatDate(asset.acquisitionDate),
            ),
            _DetailItem(label: 'Invoice No', value: asset.invoiceNo),
            _DetailItem(label: 'Supplier', value: _objectValue(asset.supplier)),
            _DetailItem(label: 'Currency', value: _objectValue(asset.currency)),
            _DetailItem(
              label: 'Purchase Cost',
              value: _formatValue(asset.purchaseCost),
            ),
            _DetailItem(
              label: 'Other Capitalizable Cost',
              value: _formatValue(asset.otherCapitalizableCost),
            ),
            _DetailItem(
              label: 'Total Capitalizable Cost',
              value: _formatValue(asset.totalCapitalizableCost),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccounting(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'ACCOUNTING',
      icon: Icons.account_balance_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(
              label: 'GL Asset Account',
              value: _objectValue(asset.glAssetAccount),
            ),
            _DetailItem(
              label: 'Accumulated Depreciation Account',
              value: _objectValue(asset.accumDepreciationAccount),
            ),
            _DetailItem(
              label: 'Depreciation Expense Account',
              value: _objectValue(asset.depreciationExpenseAccount),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocuments(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'DOCUMENTS',
      icon: Icons.attach_file_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 10,
          children: [
            _DetailItem(
              label: 'Invoice Attachment',
              value: _objectValue(asset.invoiceAttachment),
            ),
            _DetailItem(
              label: 'PO Attachment',
              value: _objectValue(asset.poAttachment),
            ),
            _DetailItem(
              label: 'Approval Reference',
              value: asset.approvalReference,
            ),
            _DetailItem(label: 'Remarks', value: asset.remarks),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context, FarAsset asset) {
    return BsDetailSection(
      title: 'STATUS',
      icon: Icons.flag_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 220,
          maxColumns: 3,
          spacing: 40,
          runSpacing: 10,
          children: [
            _StatusDetailItem(label: 'Status', status: asset.status),
            _DetailItem(
              label: 'Draft Date',
              value: _formatDate(asset.draftDate),
            ),
            _DetailItem(
              label: 'Last Updated',
              value: _formatDateTime(asset.lastUpdated),
            ),
          ],
        ),
      ),
    );
  }

  String _formatValue(dynamic value) {
    if (value == null) return '-';
    final text = value.toString();
    if (text.isEmpty) return '-';
    return text;
  }

  String _objectValue(dynamic value) {
    if (value == null) return '-';
    final text = value.toString();
    if (text.isEmpty) return '-';
    return text;
  }

  String _formatDate(dynamic value) {
    if (value == null) return '-';

    DateTime? date;
    if (value is DateTime) {
      date = value;
    } else {
      date = DateTime.tryParse(value.toString());
    }

    if (date == null) return value.toString();

    final localDate = date.toLocal();
    final day = localDate.day.toString().padLeft(2, '0');
    final month = _monthName(localDate.month);
    final year = localDate.year.toString();

    return '$day-$month-$year';
  }

  String _formatDateTime(dynamic value) {
    if (value == null) return '-';

    DateTime? date;
    if (value is DateTime) {
      date = value;
    } else {
      date = DateTime.tryParse(value.toString());
    }

    if (date == null) return value.toString();

    final localDate = date.toLocal();
    final day = localDate.day.toString().padLeft(2, '0');
    final month = _monthName(localDate.month);
    final year = localDate.year.toString();
    final hour = localDate.hour.toString().padLeft(2, '0');
    final minute = localDate.minute.toString().padLeft(2, '0');

    return '$day-$month-$year $hour:$minute';
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    if (month < 1 || month > 12) return '';
    return months[month - 1];
  }
}

class _FarAssetSummary extends StatelessWidget {
  const _FarAssetSummary({required this.asset});

  final FarAsset asset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.precision_manufacturing_outlined,
              size: 34,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _displayValue(asset.assetName),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _SummaryTag(
                      text: _displayValue(asset.draftNo),
                      type: _SummaryTagType.code,
                    ),
                    _SummaryTag(
                      text: _displayValue(asset.assetType),
                      type: _SummaryTagType.type,
                    ),
                    BsStatusBadge(
                      text: _displayValue(asset.status),
                      type: _getStatusType(asset.status),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _displayValue(dynamic value) {
    if (value == null) return '-';
    final text = value.toString();
    return text.isEmpty ? '-' : text;
  }

  static BsStatusType _getStatusType(dynamic status) {
    final value = status?.toString().toLowerCase() ?? '';

    if (value == 'approved' ||
        value == 'posted' ||
        value == 'active' ||
        value == 'registered' ||
        value == 'capitalized') {
      return BsStatusType.success;
    }

    if (value == 'rejected' ||
        value == 'cancelled' ||
        value == 'inactive' ||
        value == 'disposed') {
      return BsStatusType.danger;
    }

    if (value == 'pending' ||
        value == 'draft' ||
        value == 'waiting' ||
        value == 'incomplete') {
      return BsStatusType.warning;
    }

    return BsStatusType.info;
  }
}

enum _SummaryTagType { code, type }

class _SummaryTag extends StatelessWidget {
  const _SummaryTag({required this.text, required this.type});

  final String text;
  final _SummaryTagType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = type == _SummaryTagType.code
        ? theme.colorScheme.primary
        : Colors.deepPurple;

    final background = type == _SummaryTagType.code
        ? theme.colorScheme.primaryContainer
        : Colors.deepPurple.withValues(alpha: 0.10);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: theme.textTheme.labelMedium?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, required this.value});

  final String label;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayValue = value == null || value.toString().isEmpty
        ? '-'
        : value.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 175,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusDetailItem extends StatelessWidget {
  const _StatusDetailItem({required this.label, required this.status});

  final String label;
  final dynamic status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final statusText = status == null || status.toString().isEmpty
        ? '-'
        : status.toString();

    final statusValue = statusText.toLowerCase();

    final isSuccess =
        statusValue == 'approved' ||
        statusValue == 'posted' ||
        statusValue == 'active' ||
        statusValue == 'registered' ||
        statusValue == 'capitalized';

    final isDanger =
        statusValue == 'rejected' ||
        statusValue == 'cancelled' ||
        statusValue == 'inactive' ||
        statusValue == 'disposed';

    final color = isSuccess
        ? Colors.green
        : isDanger
        ? Colors.red
        : Colors.orange;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  statusText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
