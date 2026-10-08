/*
===============================================================================
  BizSoft ERP - Fixed Asset Register - FAR
===============================================================================

  File Name    : far_asset_form_section.dart
  Purpose      : Reusable titled card wrapper for FAR form sections.
  Company      : BizSoft Systems
  Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import 'package:flutter/material.dart';

class FarAssetFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const FarAssetFormSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}