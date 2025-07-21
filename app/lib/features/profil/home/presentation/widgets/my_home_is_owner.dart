import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/widgets/my_house_title_and_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeIsOwner extends StatelessWidget {
  const MyHomeIsOwner({super.key, required this.estProprietaire});

  final bool? estProprietaire;

  @override
  Widget build(final BuildContext context) => MyHouseTitleAndContent(
    title: Localisation.vousEtesProprietaireDeVotreLogement,
    content: FnvRadiosGroup(
      values: const {true: Localisation.oui, false: Localisation.non},
      initialValue: estProprietaire,
      onChanged: (final value) => context.read<MyHomeBloc>().add(MyHomeDataUpdated(isOwner: value)),
      direction: Direction.horizontal,
      size: DsfrComponentSize.md,
    ),
  );
}
