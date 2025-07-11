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
        _SimpleAttributionWidget(
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

class _SimpleAttributionWidget extends StatelessWidget {
  const _SimpleAttributionWidget({required this.source, this.onTap});

  final Text source;

  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) => Align(
    alignment: Alignment.bottomRight,
    child: ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('flutter_map | © '),
              MouseRegion(cursor: onTap == null ? MouseCursor.defer : SystemMouseCursors.click, child: source),
            ],
          ),
        ),
      ),
    ),
  );
}
