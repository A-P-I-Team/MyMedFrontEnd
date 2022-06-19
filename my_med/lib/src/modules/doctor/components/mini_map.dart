import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_med/src/l10n/localization_provider.dart';
import 'package:my_med/src/modules/doctor/providers/doctor_detail_provider.dart';

class MiniMap extends StatelessWidget {
  final DoctorsDetailsProvider provider;

  const MiniMap({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox.fromSize(
        size: const Size.square(72),
        child: Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              tiltGesturesEnabled: false,
              zoomGesturesEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
              myLocationButtonEnabled: false,
              onMapCreated: (_) => provider.controller = _,
              initialCameraPosition: provider.initialCameraPosition,
              markers: {
                Marker(
                  markerId: const MarkerId('marker'),
                  position: provider.initialCameraPosition.target,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan,
                  ),
                ),
              },
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 0,
              height: 18,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  gradient: LinearGradient(
                    end: Alignment.centerRight,
                    begin: Alignment.centerLeft,
                    colors: [
                      Color(0xff47BAEB),
                      Color(0xff76BBBB),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  context.localizations.routing,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: GestureDetector(
                onTap: provider.navigate,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
