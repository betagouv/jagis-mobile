import 'package:app/features/profil/home/domain/type_de_logement.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_title_and_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeMainResidence extends StatelessWidget {
  const MyHomeMainResidence({super.key, required this.typeDeLogement});

  final TypeDeLogement? typeDeLogement;

  @override
  Widget build(final BuildContext context) => MyHomeTitleAndContent(
    title: Localisation.maResidencePrincipaleEst,
    content: FnvRadiosGroup(
      values: const {TypeDeLogement.appartement: Localisation.unAppartement, TypeDeLogement.maison: Localisation.uneMaison},
      initialValue: typeDeLogement,
      onChanged: (final value) {
        if (value == null) {
          return;
        }
        context.read<MyHomeBloc>().add(MyHomeDataUpdated(housingType: value));
      },
      direction: Direction.horizontal,
      size: DsfrComponentSize.md,
    ),
  );
}
