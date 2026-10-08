// /*
// ===============================================================================
//   BizSoft ERP - Fixed Asset Register - FAR
// ===============================================================================

//   File Name    : fixed_asset_location_picker.dart
//   Purpose      : Interactive map picker for selecting a Fixed Asset location coordinate.
//   Company      : BizSoft Systems

// ===============================================================================
// */

// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class FixedAssetLocationPicker extends StatefulWidget {
//   const FixedAssetLocationPicker({
//     super.key,
//     required this.latitude,
//     required this.longitude,
//     required this.mapCenter,
//     required this.enabled,
//     required this.onLocationSelected,
//   });

//   final double? latitude;
//   final double? longitude;
//   final LatLng? mapCenter;
//   final bool enabled;
//   final ValueChanged<LatLng> onLocationSelected;

//   @override
//   State<FixedAssetLocationPicker> createState() =>
//       _FixedAssetLocationPickerState();
// }

// class _FixedAssetLocationPickerState
//     extends State<FixedAssetLocationPicker> {
//   final MapController _mapController = MapController();

//   LatLng? _selectedPoint;
//   bool _mapReady = false;

//   @override
//   void initState() {
//     super.initState();
//     _selectedPoint = _savedLocation();
//   }

//   @override
//   void didUpdateWidget(
//     covariant FixedAssetLocationPicker oldWidget,
//   ) {
//     super.didUpdateWidget(oldWidget);

//     final oldLat = oldWidget.latitude;
//     final oldLng = oldWidget.longitude;

//     final newLat = widget.latitude;
//     final newLng = widget.longitude;

//     if (oldLat != newLat || oldLng != newLng) {
//       _selectedPoint = _savedLocation();
//     }

//     final oldCenter = oldWidget.mapCenter;
//     final newCenter = widget.mapCenter;

//     final centerChanged =
//         oldCenter?.latitude != newCenter?.latitude ||
//         oldCenter?.longitude != newCenter?.longitude;

//     if (centerChanged && newCenter != null) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         if (!mounted) {
//           return;
//         }

//         _moveMapTo(
//           newCenter,
//           zoom: _getZoomForCenter(newCenter),
//         );
//       });
//     }
//   }

//   LatLng? _savedLocation() {
//     if (widget.latitude == null || widget.longitude == null) {
//       return null;
//     }

//     return LatLng(
//       widget.latitude!,
//       widget.longitude!,
//     );
//   }

//   LatLng _defaultCenter() {
//     // Myanmar approximate center.
//     return const LatLng(
//       21.9162,
//       95.9560,
//     );
//   }

//   LatLng _getMapCenter() {
//     final saved = _savedLocation();

//     if (saved != null) {
//       return saved;
//     }

//     if (widget.mapCenter != null) {
//       return widget.mapCenter!;
//     }

//     return _defaultCenter();
//   }

//   double _getZoomForCenter(
//     LatLng center,
//   ) {
//     final saved = _savedLocation();

//     if (saved != null &&
//         saved.latitude == center.latitude &&
//         saved.longitude == center.longitude) {
//       return 15;
//     }

//     return 10;
//   }

//   void _moveMapTo(
//     LatLng point, {
//     double zoom = 10,
//   }) {
//     if (!_mapReady) {
//       return;
//     }

//     try {
//       _mapController.move(
//         point,
//         zoom,
//       );
//     } catch (_) {}
//   }

//   Future<void> _onMapTap(
//     TapPosition tapPosition,
//     LatLng point,
//   ) async {
//     if (!widget.enabled) {
//       return;
//     }

//     setState(() {
//       _selectedPoint = point;
//     });

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         final theme = Theme.of(context);

//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(
//                 Icons.location_on,
//                 color: theme.colorScheme.primary,
//               ),
//               const SizedBox(width: 8),
//               const Text('Confirm Asset Location'),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Use this location for the fixed asset?',
//               ),
//               const SizedBox(height: 16),
//               _ConfirmCoordinateBox(
//                 label: 'Latitude',
//                 value: point.latitude.toStringAsFixed(6),
//               ),
//               const SizedBox(height: 10),
//               _ConfirmCoordinateBox(
//                 label: 'Longitude',
//                 value: point.longitude.toStringAsFixed(6),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//               child: const Text('Cancel'),
//             ),
//             FilledButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//               icon: const Icon(Icons.check),
//               label: const Text('Confirm'),
//             ),
//           ],
//         );
//       },
//     );

//     if (!mounted) {
//       return;
//     }

//     if (confirmed == true) {
//       widget.onLocationSelected(point);
//     } else {
//       setState(() {
//         _selectedPoint = null;
//       });
//     }
//   }

//   Future<void> _confirmLocation() async {
//     final point = _selectedPoint;

//     if (point == null) {
//       return;
//     }

//     final confirmed = await showDialog<bool>(
//       context: context,
//       builder: (context) {
//         final theme = Theme.of(context);

//         return AlertDialog(
//           title: Row(
//             children: [
//               Icon(
//                 Icons.location_on,
//                 color: theme.colorScheme.primary,
//               ),
//               const SizedBox(width: 8),
//               const Text(
//                 'Confirm Asset Location',
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Are you sure you want to use this location?',
//               ),
//               const SizedBox(height: 20),
//               _ConfirmCoordinateBox(
//                 label: 'Latitude',
//                 value: point.latitude.toStringAsFixed(6),
//               ),
//               const SizedBox(height: 10),
//               _ConfirmCoordinateBox(
//                 label: 'Longitude',
//                 value: point.longitude.toStringAsFixed(6),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(false);
//               },
//               child: const Text(
//                 'Cancel',
//               ),
//             ),
//             FilledButton.icon(
//               onPressed: () {
//                 Navigator.of(context).pop(true);
//               },
//               icon: const Icon(
//                 Icons.check,
//               ),
//               label: const Text(
//                 'Confirm',
//               ),
//             ),
//           ],
//         );
//       },
//     );

//     if (confirmed == true) {
//       widget.onLocationSelected(point);
//     }
//   }

//   void _clearLocation() {
//     if (!widget.enabled) {
//       return;
//     }

//     setState(() {
//       _selectedPoint = null;
//     });
//   }

//   String _formatCoordinate(
//     double? value,
//   ) {
//     if (value == null) {
//       return '-';
//     }

//     return value.toStringAsFixed(6);
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     final selected = _selectedPoint;
//     final mapCenter = _getMapCenter();
//     final hasSelection = selected != null;
//     final theme = Theme.of(context);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 420,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(
//               color: theme.dividerColor,
//             ),
//           ),
//           clipBehavior: Clip.antiAlias,
//           child: Stack(
//             children: [
//               FlutterMap(
//                 mapController: _mapController,
//                 options: MapOptions(
//                   initialCenter: mapCenter,
//                   initialZoom: _getZoomForCenter(mapCenter),
//                   onMapReady: () {
//                     _mapReady = true;

//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       if (!mounted) {
//                         return;
//                       }

//                       _moveMapTo(
//                         mapCenter,
//                         zoom: _getZoomForCenter(mapCenter),
//                       );
//                     });
//                   },
//                   onTap: _onMapTap,
//                   interactionOptions: InteractionOptions(
//                     flags: widget.enabled
//                         ? InteractiveFlag.all
//                         : InteractiveFlag.none,
//                   ),
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                     userAgentPackageName: 'com.bizsoft.erp',
//                   ),
//                   if (selected != null)
//                     MarkerLayer(
//                       markers: [
//                         Marker(
//                           point: selected,
//                           width: 50,
//                           height: 65,
//                           alignment: Alignment.topCenter,
//                           child: const Icon(
//                             Icons.location_pin,
//                             size: 50,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ],
//                     ),
//                 ],
//               ),
//               if (!widget.enabled)
//                 Positioned.fill(
//                   child: Container(
//                     color: Colors.white.withOpacity(0.35),
//                     child: Center(
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.black87,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: const Text(
//                           'Select Region and Zone first',
//                           style: TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               Positioned(
//                 top: 12,
//                 left: 12,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: const [
//                       BoxShadow(
//                         blurRadius: 6,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     widget.enabled
//                         ? 'Click on the map to select asset location'
//                         : 'Select Region and Zone first',
//                     style: theme.textTheme.bodySmall,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(14),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//               color: theme.dividerColor,
//             ),
//             color: theme.colorScheme.surface,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     hasSelection
//                         ? Icons.location_on
//                         : Icons.location_off_outlined,
//                     size: 20,
//                     color: hasSelection
//                         ? Colors.red
//                         : theme.colorScheme.onSurfaceVariant,
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     hasSelection
//                         ? 'Selected Asset Location'
//                         : 'No Location Selected',
//                     style: theme.textTheme.titleSmall,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _CoordinateBox(
//                       label: 'Latitude',
//                       value: _formatCoordinate(
//                         selected?.latitude,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: _CoordinateBox(
//                       label: 'Longitude',
//                       value: _formatCoordinate(
//                         selected?.longitude,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               if (hasSelection) ...[
//                 const SizedBox(height: 14),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     OutlinedButton.icon(
//                       onPressed: widget.enabled ? _clearLocation : null,
//                       icon: const Icon(Icons.clear),
//                       label: const Text('Clear'),
//                     ),
//                     const SizedBox(width: 10),
//                     FilledButton.icon(
//                       onPressed: widget.enabled ? _confirmLocation : null,
//                       icon: const Icon(Icons.check),
//                       label: const Text('Confirm Location'),
//                     ),
//                   ],
//                 ),
//               ],
//             ],
//           ),
//         ),
//         const SizedBox(height: 6),
//         Text(
//           hasSelection
//               ? 'Click another point to change the location, then confirm.'
//               : 'Click anywhere on the map to choose the exact fixed asset location.',
//           style: theme.textTheme.bodySmall,
//         ),
//       ],
//     );
//   }
// }

// class _CoordinateBox extends StatelessWidget {
//   const _CoordinateBox({
//     required this.label,
//     required this.value,
//   });

//   final String label;
//   final String value;

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     final theme = Theme.of(context);

//     return Container(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 12,
//         vertical: 10,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         border: Border.all(
//           color: theme.dividerColor,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: theme.textTheme.bodySmall,
//           ),
//           const SizedBox(height: 3),
//           Text(
//             value,
//             style: theme.textTheme.bodyMedium?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ConfirmCoordinateBox extends StatelessWidget {
//   const _ConfirmCoordinateBox({
//     required this.label,
//     required this.value,
//   });

//   final String label;
//   final String value;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 14,
//         vertical: 12,
//       ),
//       decoration: BoxDecoration(
//         color: theme.colorScheme.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(
//           color: theme.colorScheme.outlineVariant,
//         ),
//       ),
//       child: Row(
//         children: [
//           SizedBox(
//             width: 80,
//             child: Text(
//               label,
//               style: theme.textTheme.bodySmall?.copyWith(
//                 color: theme.colorScheme.onSurfaceVariant,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: theme.textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
/*
===============================================================================
  BizSoft ERP - Fixed Asset Register - FAR
===============================================================================

  File Name    : far_asset_location_picker.dart
  Purpose      : Interactive map picker for selecting a Fixed Asset location coordinate.
  Company      : BizSoft Systems

===============================================================================
*/

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FarAssetLocationPicker extends StatefulWidget {
  const FarAssetLocationPicker({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.mapCenter,
    required this.enabled,
    required this.onLocationSelected,
  });

  final double? latitude;
  final double? longitude;
  final LatLng? mapCenter;
  final bool enabled;
  final ValueChanged<LatLng> onLocationSelected;

  @override
  State<FarAssetLocationPicker> createState() =>
      _FarAssetLocationPickerState();
}

class _FarAssetLocationPickerState extends State<FarAssetLocationPicker> {
  final MapController _mapController = MapController();

  LatLng? _selectedPoint;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _selectedPoint = _savedLocation();
  }

  @override
  void didUpdateWidget(covariant FarAssetLocationPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldLat = oldWidget.latitude;
    final oldLng = oldWidget.longitude;
    final newLat = widget.latitude;
    final newLng = widget.longitude;

    if (oldLat != newLat || oldLng != newLng) {
      _selectedPoint = _savedLocation();
    }

    final oldCenter = oldWidget.mapCenter;
    final newCenter = widget.mapCenter;

    final centerChanged = oldCenter?.latitude != newCenter?.latitude ||
        oldCenter?.longitude != newCenter?.longitude;

    if (centerChanged && newCenter != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _moveMapTo(newCenter, zoom: _getZoomForCenter(newCenter));
      });
    }
  }

  // ─────────────────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────────────────
  LatLng? _savedLocation() {
    if (widget.latitude == null || widget.longitude == null) {
      return null;
    }

    return LatLng(widget.latitude!, widget.longitude!);
  }

  LatLng _defaultCenter() {
    // Myanmar approximate center.
    return const LatLng(21.9162, 95.9560);
  }

  LatLng _getMapCenter() {
    final saved = _savedLocation();
    if (saved != null) return saved;

    if (widget.mapCenter != null) return widget.mapCenter!;

    return _defaultCenter();
  }

  double _getZoomForCenter(LatLng center) {
    final saved = _savedLocation();

    if (saved != null &&
        saved.latitude == center.latitude &&
        saved.longitude == center.longitude) {
      return 15;
    }

    return 10;
  }

  void _moveMapTo(LatLng point, {double zoom = 10}) {
    if (!_mapReady) return;

    try {
      _mapController.move(point, zoom);
    } catch (_) {}
  }

  // ─────────────────────────────────────────────────────────
  // MAP TAP
  // ─────────────────────────────────────────────────────────
  Future<void> _onMapTap(
    TapPosition tapPosition,
    LatLng point,
  ) async {
    if (!widget.enabled) return;

    setState(() {
      _selectedPoint = point;
    });

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.location_on,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Text('Confirm Asset Location'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Use this location for the fixed asset?',
              ),
              const SizedBox(height: 16),
              _ConfirmCoordinateBox(
                label: 'Latitude',
                value: point.latitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 10),
              _ConfirmCoordinateBox(
                label: 'Longitude',
                value: point.longitude.toStringAsFixed(6),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.check),
              label: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed == true) {
      widget.onLocationSelected(point);
    } else {
      setState(() {
        _selectedPoint = null;
      });
    }
  }

  // ─────────────────────────────────────────────────────────
  // CONFIRM CURRENT SELECTION
  // ─────────────────────────────────────────────────────────
  Future<void> _confirmLocation() async {
    final point = _selectedPoint;
    if (point == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.location_on,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              const Text('Confirm Asset Location'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Are you sure you want to use this location?',
              ),
              const SizedBox(height: 20),
              _ConfirmCoordinateBox(
                label: 'Latitude',
                value: point.latitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 10),
              _ConfirmCoordinateBox(
                label: 'Longitude',
                value: point.longitude.toStringAsFixed(6),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pop(true),
              icon: const Icon(Icons.check),
              label: const Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      widget.onLocationSelected(point);
    }
  }

  void _clearLocation() {
    if (!widget.enabled) return;

    setState(() {
      _selectedPoint = null;
    });
  }

  String _formatCoordinate(double? value) {
    if (value == null) return '-';
    return value.toStringAsFixed(6);
  }

  // ─────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final selected = _selectedPoint;
    final mapCenter = _getMapCenter();
    final hasSelection = selected != null;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: theme.dividerColor),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: mapCenter,
                  initialZoom: _getZoomForCenter(mapCenter),
                  onMapReady: () {
                    _mapReady = true;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (!mounted) return;
                      _moveMapTo(
                        mapCenter,
                        zoom: _getZoomForCenter(mapCenter),
                      );
                    });
                  },
                  onTap: _onMapTap,
                  interactionOptions: InteractionOptions(
                    flags: widget.enabled
                        ? InteractiveFlag.all
                        : InteractiveFlag.none,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.bizsoft.erp',
                  ),
                  if (selected != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: selected,
                          width: 50,
                          height: 65,
                          alignment: Alignment.topCenter,
                          child: const Icon(
                            Icons.location_pin,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
              if (!widget.enabled)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.35),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Select Region and Zone first',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    widget.enabled
                        ? 'Click on the map to select asset location'
                        : 'Select Region and Zone first',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: theme.dividerColor),
            color: theme.colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    hasSelection
                        ? Icons.location_on
                        : Icons.location_off_outlined,
                    size: 20,
                    color: hasSelection
                        ? Colors.red
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    hasSelection
                        ? 'Selected Asset Location'
                        : 'No Location Selected',
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _CoordinateBox(
                      label: 'Latitude',
                      value: _formatCoordinate(selected?.latitude),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CoordinateBox(
                      label: 'Longitude',
                      value: _formatCoordinate(selected?.longitude),
                    ),
                  ),
                ],
              ),
              if (hasSelection) ...[
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      onPressed: widget.enabled ? _clearLocation : null,
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear'),
                    ),
                    const SizedBox(width: 10),
                    FilledButton.icon(
                      onPressed: widget.enabled ? _confirmLocation : null,
                      icon: const Icon(Icons.check),
                      label: const Text('Confirm Location'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          hasSelection
              ? 'Click another point to change the location, then confirm.'
              : 'Click anywhere on the map to choose the exact fixed asset location.',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════
// COORDINATE BOX
// ═══════════════════════════════════════════════════════════
class _CoordinateBox extends StatelessWidget {
  const _CoordinateBox({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodySmall),
          const SizedBox(height: 3),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// CONFIRM COORDINATE BOX
// ═══════════════════════════════════════════════════════════
class _ConfirmCoordinateBox extends StatelessWidget {
  const _ConfirmCoordinateBox({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}