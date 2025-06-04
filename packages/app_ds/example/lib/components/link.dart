import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvLink, name: 'Default')
Widget buildLinkUseCase(final BuildContext context) => FnvLink(
  label: context.knobs.string(label: 'Libellé', initialValue: 'Libellé lien'),
  iconPosition: context.knobs.list(
    label: "Position de l'icône",
    options: DsfrLinkIconPosition.values,
    initialOption: DsfrLinkIconPosition.start,
  ),
  icon: context.knobs.listOrNull(label: 'Icône', options: [Icons.chevron_left, Icons.chevron_right]),
  onTap: () {},
  size: context.knobs.list(label: 'Taille', options: DsfrComponentSize.values, initialOption: DsfrComponentSize.lg),
  enabled: context.knobs.boolean(label: 'Activé', initialValue: true),
  textAlign: TextAlign.center,
);
