import 'package:app/core/infrastructure/url_launcher.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FnvMap extends StatelessWidget {
  const FnvMap({super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  Widget build(final BuildContext context) {
    final latLng = LatLng(latitude, longitude);

    return FlutterMap(
      options: MapOptions(initialCenter: latLng),
      children: [
        TileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', userAgentPackageName: 'fr.gouv.agir'),
        SimpleAttributionWidget(
          source: const Text(Localisation.contributeursOpenStreetMap),
          onTap: () async {
            await FnvUrlLauncher.launch('https://www.openstreetmap.org/copyright');
          },
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: latLng,
              height: 50,
              rotate: true,
              child: const Icon(DsfrIcons.mapMapPin2Fill, color: DsfrColors.blueFranceSun113),
            ),
          ],
        ),
      ],
    );
  }
}
