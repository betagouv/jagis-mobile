import 'dart:async';

import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/fondamentaux/colors.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_bloc.dart';
import 'package:app/features/bibliotheque/presentation/bloc/bibliotheque_event.dart';
import 'package:app/features/bibliotheque/presentation/pages/contenu.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BibliothequeView extends StatelessWidget {
  const BibliothequeView({super.key});

  @override
  Widget build(final context) {
    const padding = paddingVerticalPage;

    return CustomScrollView(
      primary: true,
      slivers: [
        const SliverPadding(padding: EdgeInsets.only(top: padding)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          sliver: SliverList.list(
            children: const [
              FnvTitle(title: Localisation.bibliotheque, subtitle: Localisation.bibliothequeSousTitre),
              SizedBox(height: DsfrSpacings.s3w),
              _ChampRecherche(),
              SizedBox(height: DsfrSpacings.s1w),
              _Thematiques(),
              SizedBox(height: DsfrSpacings.s1w),
              _Favorites(),
              SizedBox(height: DsfrSpacings.s1w),
              _Nombre(),
              SizedBox(height: DsfrSpacings.s2w),
            ],
          ),
        ),
        const SliverPadding(padding: EdgeInsets.symmetric(horizontal: padding), sliver: _SliverListe()),
        const SliverSafeArea(sliver: SliverPadding(padding: EdgeInsets.only(bottom: padding))),
      ],
    );
  }
}

class _Favorites extends StatelessWidget {
  const _Favorites();

  @override
  Widget build(final context) => DsfrToggleSwitch(
    label: Localisation.mesFavoris,
    value: context.select<BibliothequeBloc, bool>((final value) => value.state.isFavorites),
    onChanged: (final value) => context.read<BibliothequeBloc>().add(BibliothequeFavorisSelectionnee(value)),
  );
}

class _Thematiques extends StatelessWidget {
  const _Thematiques();

  @override
  Widget build(final context) {
    final filtres = context.select<BibliothequeBloc, List<BibliothequeFiltre>>((final value) => value.state.bibliotheque.filtres);
    const s1w = DsfrSpacings.s1w;

    return Wrap(
      spacing: s1w,
      runSpacing: s1w,
      children:
          filtres
              .map((final thematique) => _Tag(label: thematique.titre, thematique: thematique.code, choisi: thematique.choisi))
              .toList(),
    );
  }
}

class _Tag extends StatefulWidget {
  const _Tag({required this.label, required this.thematique, required this.choisi});

  final String label;
  final String thematique;
  final bool choisi;

  @override
  State<_Tag> createState() => _TagState();
}

class _TagState extends State<_Tag> with MaterialStateMixin<_Tag> {
  @override
  Widget build(final context) {
    const blue = DsfrColors.blueFranceSun113;
    const borderRadius = BorderRadius.all(Radius.circular(DsfrSpacings.s4w));

    return DsfrFocusWidget(
      isFocused: isFocused,
      borderRadius: borderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.choisi ? blue : null,
          border: const Border.fromBorderSide(BorderSide(color: blue)),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: () => context.read<BibliothequeBloc>().add(BibliothequeThematiqueSelectionnee(widget.thematique)),
          onHighlightChanged: updateMaterialState(WidgetState.pressed),
          onHover: updateMaterialState(WidgetState.hovered),
          focusColor: FnvColors.transparent,
          borderRadius: borderRadius,
          onFocusChange: updateMaterialState(WidgetState.focused),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Text(widget.label, style: DsfrTextStyle.bodySmMedium(color: widget.choisi ? Colors.white : blue)),
          ),
        ),
      ),
    );
  }
}

class _ChampRecherche extends StatefulWidget {
  const _ChampRecherche();

  @override
  State<_ChampRecherche> createState() => _ChampRechercheState();
}

class _ChampRechercheState extends State<_ChampRecherche> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(final context) => DsfrInput(
    label: Localisation.rechercherParTitre,
    onChanged: (final value) {
      if (_timer?.isActive ?? false) {
        _timer?.cancel();
      }
      _timer = Timer(
        const Duration(milliseconds: 500),
        () => context.read<BibliothequeBloc>().add(BibliothequeRechercheSaisie(value)),
      );
    },
    keyboardType: TextInputType.text,
  );
}

class _Nombre extends StatelessWidget {
  const _Nombre();

  @override
  Widget build(final context) {
    final nombreArticle = context.select<BibliothequeBloc, int>((final value) => value.state.bibliotheque.contenus.length);

    return Text(Localisation.nombreArticle(nombreArticle), style: const DsfrTextStyle.bodyLgBold());
  }
}

class _SliverListe extends StatelessWidget {
  const _SliverListe();

  @override
  Widget build(final context) {
    final contenus = context.select<BibliothequeBloc, List<Recommandation>>((final value) => value.state.bibliotheque.contenus);

    return contenus.isEmpty
        ? SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            spacing: DsfrSpacings.s2w,
            children: [
              FnvSvg.asset(AssetImages.bibliothequeEmpty),
              const Text(Localisation.bibliothequeAucunArticle, style: DsfrTextStyle.headline4()),
            ],
          ),
        )
        : SliverList.separated(
          itemBuilder: (final context, final index) => Contenu(contenu: contenus[index]),
          separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s2w),
          itemCount: contenus.length,
        );
  }
}
