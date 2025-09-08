import 'package:app/features/profil/home/presentation/bloc/my_home_bloc.dart';
import 'package:app/features/profil/home/presentation/bloc/my_home_event.dart';
import 'package:app/features/profil/home/presentation/widgets/my_home_title_and_content.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app_ds/app_ds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dsfr/flutter_dsfr.dart';

class MyHomeOver15Years extends StatelessWidget {
  const MyHomeOver15Years({super.key, required this.plusDe15Ans});

  final bool? plusDe15Ans;

  @override
  Widget build(final BuildContext context) => MyHomeTitleAndContent(
    title: Localisation.monLogementPlusDe15Ans,
    content: FnvRadiosGroup(
      values: const {true: Localisation.oui, false: Localisation.non},
      initialValue: plusDe15Ans,
      onChanged: (final value) => context.read<MyHomeBloc>().add(MyHomeDataUpdated(over15Years: value)),
      direction: Direction.horizontal,
      size: DsfrComponentSize.md,
    ),
  );
}
