/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/partner_form_field_helpers.dart
 *
 * Purpose:
 *   Partner compatibility aliases for common BizSoft bound field helpers.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier, Customer, Employee, Doctor, Patient, Bank, and other profiles extend Partner.
 *   - Partner role and relationship are decided by caller program or backend onboarding service.
 *   - UI must not enforce final business policy; backend is the source of truth.
 *   - API calls must go through Repository and API Service.
 *   - First identity is displayed on the main form.
 *   - Additional identities are entered through dialog, side panel, or accordion.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
import '../../../../shared/inputs/bs_bound_fields.dart';

typedef PartnerBoundTextField = BsBoundTextField;
typedef PartnerBoundDateField = BsBoundDateField;
