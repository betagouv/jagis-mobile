import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(type: FnvLink, name: 'Default')
Widget buildLinkUseCase(final BuildContext context) => FnvLink(
  label: context.knobs.string(label: 'Libellé', initialValue: '🎨 Libellé'),
  onTap: () {},
  size: context.knobs.list(label: 'Taille', options: DsfrComponentSize.values, initialOption: DsfrComponentSize.lg),
  enabled: context.knobs.boolean(label: 'Activé', initialValue: true),
  textAlign: TextAlign.center,
);
