import 'package:dsfr/dsfr.dart';
import 'package:dsfr_example/page_item.dart';
import 'package:flutter/material.dart';

class ModalsPage extends StatelessWidget {
  const ModalsPage({super.key});

  static final model = PageItem(title: 'Modales', pageBuilder: (final context) => const ModalsPage());

  @override
  Widget build(final context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      DsfrButton(
        label: 'Ouvrir la bottom sheet',
        variant: DsfrButtonVariant.primary,
        size: DsfrButtonSize.lg,
        onPressed: () async {
          await DsfrModal.showModal<void>(
            context: context,
            builder:
                (final context) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Veuillez confirmer la suppression du compte', style: DsfrTextStyle.headline4()),
                    const SizedBox(height: DsfrSpacings.s2w),
                    const Text(
                      'Voulez-vous vraiment supprimer votre compte ainsi que les données associées ?',
                      style: DsfrTextStyle.bodyMd(),
                    ),
                    const Text('Attention : Aucune donnée ne pourra être récupérée.', style: DsfrTextStyle.bodyMdBold()),
                    const SizedBox(height: DsfrSpacings.s4w),
                    DsfrButton(
                      label: 'Confirmer',
                      variant: DsfrButtonVariant.primary,
                      size: DsfrButtonSize.lg,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: DsfrSpacings.s2w),
                    DsfrButton(
                      label: 'Annuler',
                      variant: DsfrButtonVariant.secondary,
                      size: DsfrButtonSize.lg,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
            name: 'name',
          );
        },
      ),
    ],
  );
}
