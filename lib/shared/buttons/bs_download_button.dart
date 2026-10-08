/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_download_button.dart
 Purpose      : Reusable download button for file export actions.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import 'package:flutter/material.dart';

class BsDownloadButton extends StatelessWidget {
  const BsDownloadButton({
    super.key,
    required this.onPressed,
    this.label = 'Download',
    this.icon = Icons.download_outlined,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String label;
  final IconData icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Icon(
                icon,
                size: 20,
              ),
        label: Text(
          isLoading ? 'Downloading...' : label,
        ),
      ),
    );
  }
}