import 'package:app/features/profil/home/domain/area.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/widgets/my_house_title_and_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeArea extends StatelessWidget {
  const MyHomeArea({super.key, required this.superficie});

  final Area? superficie;

  @override
  Widget build(final BuildContext context) => MyHouseTitleAndContent(
    title: Localisation.quelleEstLaSuperficie,
    content: FnvRadiosGroup(
      values: const {
        Area.s35: Localisation.moinsDe35m2,
        Area.s70: Localisation.entre35et70m2,
        Area.s100: Localisation.entre70et100m2,
        Area.s150: Localisation.entre100et150m2,
        Area.s150EtPlus: Localisation.plusDe150m2,
      },
      initialValue: superficie,
      onChanged: (final value) => context.read<MyHomeBloc>().add(MyHomeDataUpdated(area: value)),
      direction: Direction.vertical,
      size: DsfrComponentSize.md,
    ),
  );
}
