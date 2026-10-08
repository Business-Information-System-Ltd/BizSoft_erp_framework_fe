/*
===============================================================================
 BizSoft ERP - Common Setup - Branch
===============================================================================

 File Name    : branch_view_page.dart
 Purpose      : Read-only Branch detail page.
 Company      : BizSoft Systems

===============================================================================
*/

import 'package:bizsoft_frontend_framework/shared/buttons/bs_cancel_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

// import '../../../../../shared/buttons/bs_action_button.dart';
import '../../../../../shared/feedback/bs_error_state.dart';
import '../../../../../shared/feedback/bs_loading_overlay.dart';
import '../../../../../shared/layout/bs_detail_area.dart';
import '../../../../../shared/layout/bs_form_row.dart';
import '../../../../../shared/layout/bs_page.dart';
import '../../../../../shared/layout/bs_page_header.dart';
import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';
import '../../../../../shared/status/bs_status_badge.dart';

import '../../domain/model/branch.dart';
import '../controller/branch_view_controller.dart';

class BranchViewPage extends ConsumerWidget {
  const BranchViewPage({super.key, required this.branchId});

  final int branchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(branchViewControllerProvider(branchId));

    return BsPage(
      title: 'Branch Detail View ',

      breadcrumb: const BsBreadcrumb(
        items: [
          BsBreadcrumbItem(label: 'Home', routePath: '/'),
          BsBreadcrumbItem(label: 'Common Setup'),
          BsBreadcrumbItem(label: 'Branch', routePath: '/common/branches'),
          BsBreadcrumbItem(label: 'View'),
        ],
      ),

      header: BsPageHeader(
        title: 'Branch Detail View',
        actions: [
          BsCancelButton(
            onPressed: () {
              context.go('/common/branches/');
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
                  .read(branchViewControllerProvider(branchId).notifier)
                  .refresh();
            },
          );
        },

        data: (branch) {
          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              _BranchSummary(branch: branch),

              const SizedBox(height: 12),

              _buildBasicInformation(context, ref, branch),

              const SizedBox(height: 12),

              _buildLocation(context, branch),

              const SizedBox(height: 12),

              _buildResponsibilities(context, branch),

              const SizedBox(height: 12),
              _buildAddress(context, branch),

              const SizedBox(height: 12),

              _buildStatus(context, branch),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBasicInformation(
    BuildContext context,
    WidgetRef ref,
    Branch branch,
  ) {
    final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);

    final legalEntityName =
        currentLegalEntity?.legalEntityName ?? branch.legalEntity.toString();

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
            _DetailItem(label: 'Legal Entity', value: legalEntityName),

            _DetailItem(label: 'Branch Type', value: branch.branchType),

            _DetailItem(label: 'Branch Code', value: branch.branchCode),

            _DetailItem(label: 'Branch Name', value: branch.branchName),
          ],
        ),
      ),
    );
  }

  Widget _buildLocation(BuildContext context, Branch branch) {
    return BsDetailSection(
      title: 'LOCATION',
      icon: Icons.location_on_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 2,
          spacing: 30,
          runSpacing: 20,
          children: [
            _DetailItem(
              label: 'Region',
              value: branch.regionDetail?.regionName,
            ),

            _DetailItem(label: 'Zone', value: branch.zoneDetail?.zoneCode),
            _DetailItem(label: 'Latitude', value: branch.latitude?.toString()),

            _DetailItem(
              label: 'Longitude',
              value: branch.longitude?.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddress(BuildContext context, Branch branch) {
    return BsDetailSection(
      title: 'ADDRESS',
      icon: Icons.home_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: BsFormRow(
          fieldWidth: 300,
          maxColumns: 3,
          spacing: 30,
          runSpacing: 20,
          children: [
            _DetailItem(
              label: 'Address Line 1',
              value: branch.addressDetail?.addressLine1,
            ),

            _DetailItem(
              label: 'Address Line 2',
              value: branch.addressDetail?.addressLine2,
            ),

            _DetailItem(
              label: 'Township',
              value: branch.addressDetail?.township,
            ),

            _DetailItem(label: 'City', value: branch.addressDetail?.city),

            _DetailItem(
              label: 'Region',
              value: branch.addressDetail?.regionDetail?.regionName,
            ),

            _DetailItem(
              label: 'Zone',
              value: branch.addressDetail?.zoneDetail?.zoneName,
            ),

            _DetailItem(
              label: 'Postal Code',
              value: branch.addressDetail?.postalCode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsibilities(BuildContext context, Branch branch) {
    return BsDetailSection(
      title: 'RESPONSIBILITIES',
      icon: Icons.verified_outlined,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: Wrap(
          spacing: 25,
          runSpacing: 10,
          children: [
            _ResponsibilityItem(
              label: 'Cost Center',
              enabled: branch.isCostCenter,
            ),

            _ResponsibilityItem(
              label: 'Profit Center',
              enabled: branch.isProfitCenter,
            ),

            _ResponsibilityItem(
              label: 'Inventory Storable',
              enabled: branch.isInventoryStorable,
            ),

            _ResponsibilityItem(
              label: 'Asset Assignable',
              enabled: branch.isAssetAssignable,
            ),

            _ResponsibilityItem(
              label: 'Head Office',
              enabled: branch.isHeadOffice,
            ),

            _ResponsibilityItem(
              label: 'Bank Branch',
              enabled: branch.isBankBranch,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(BuildContext context, Branch branch) {
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
            _StatusDetailItem(label: 'Status', isActive: branch.isActive),

            _DetailItem(
              label: 'Effective From',
              value: _formatDate(branch.effectiveFrom),
            ),

            _DetailItem(
              label: 'Effective To',
              value: _formatDate(branch.effectiveTo),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? value) {
    if (value == null) {
      return '-';
    }

    final date = value.toLocal();

    final day = date.day.toString().padLeft(2, '0');

    final month = _monthName(date.month);

    final year = date.year.toString();

    return '$day-$month-$year';
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

    return months[month - 1];
  }
}

class _BranchSummary extends StatelessWidget {
  const _BranchSummary({required this.branch});

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        // borderRadius: BorderRadius.circular(10),
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
              Icons.account_balance_outlined,
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
                  branch.branchName,
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
                      text: branch.branchCode,
                      type: _SummaryTagType.code,
                    ),

                    _SummaryTag(
                      text: branch.branchType,
                      type: _SummaryTagType.type,
                    ),

                    BsStatusBadge(
                      text: branch.isActive ? 'Active' : 'Inactive',
                      type: branch.isActive
                          ? BsStatusType.success
                          : BsStatusType.danger,
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
  final String? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 145,
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
              value == null || value!.isEmpty ? '-' : value!,
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

class _ResponsibilityItem extends StatelessWidget {
  const _ResponsibilityItem({required this.label, required this.enabled});

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final color = enabled ? Colors.green : Colors.red;

    final background = enabled
        ? Colors.green.withValues(alpha: 0.08)
        : Colors.red.withValues(alpha: 0.08);

    return Container(
      width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: [
          Icon(
            enabled ? Icons.check_circle_outline : Icons.cancel_outlined,
            size: 18,
            color: color,
          ),

          const SizedBox(width: 7),

          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
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
  const _StatusDetailItem({required this.label, required this.isActive});

  final String label;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                    color: isActive ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 8),

                Text(
                  isActive ? 'Active' : 'Inactive',
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
