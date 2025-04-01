import 'package:app/core/assets/images.dart';
import 'package:app/core/infrastructure/svg.dart';
import 'package:app/core/presentation/widgets/composants/tag.dart';
import 'package:app/core/presentation/widgets/fondamentaux/rounded_rectangle_border.dart';
import 'package:app/features/bibliotheque/domain/library.dart';
import 'package:app/features/bibliotheque/presentation/bloc/library_bloc.dart';
import 'package:app/features/bibliotheque/presentation/bloc/library_event.dart';
import 'package:app/features/bibliotheque/presentation/pages/library_content.dart';
import 'package:app/features/profil/profil/presentation/widgets/fnv_title.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

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
            children: [
              const FnvTitle(title: Localisation.bibliotheque, subtitle: Localisation.bibliothequeSousTitre),
              const SizedBox(height: DsfrSpacings.s3w),
              DsfrSearchBar(onChanged: (final value) => context.read<LibraryBloc>().add(LibrarySearchEntered(value))),
              const SizedBox(height: DsfrSpacings.s1w),
              const _Thematiques(),
              const SizedBox(height: DsfrSpacings.s1w),
              const _Favorites(),
              const SizedBox(height: DsfrSpacings.s1w),
              const _AlreadyRead(),
              const SizedBox(height: DsfrSpacings.s2w),
              const _Nombre(),
              const SizedBox(height: DsfrSpacings.s2w),
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
    value: context.select<LibraryBloc, bool>((final value) => value.state.isFavorites),
    onChanged: (final value) => context.read<LibraryBloc>().add(LibraryFavoritesSelected(value)),
  );
}

class _AlreadyRead extends StatelessWidget {
  const _AlreadyRead();

  @override
  Widget build(final context) => DsfrToggleSwitch(
    label: 'Articles déjà lus',
    value: context.select<LibraryBloc, bool>((final value) => value.state.areAlreadyRead),
    onChanged: (final value) => context.read<LibraryBloc>().add(LibraryAlreadyReadSelected(value)),
  );
}

class _Thematiques extends StatelessWidget {
  const _Thematiques();

  @override
  Widget build(final context) {
    final filtres = context.select<LibraryBloc, List<LibraryFilter>>((final value) => value.state.library.filters);
    const s1w = DsfrSpacings.s1w;

    return Wrap(
      spacing: s1w,
      runSpacing: s1w,
      children:
          filtres
              .map(
                (final thematique) => FnvTag(
                  label: thematique.title,
                  selected: thematique.isSelected,
                  onTap: () => context.read<LibraryBloc>().add(LibraryThemeSelected(thematique.code)),
                ),
              )
              .toList(),
    );
  }
}

class _Nombre extends StatelessWidget {
  const _Nombre();

  @override
  Widget build(final context) {
    final nombreArticle = context.select<LibraryBloc, int>((final value) => value.state.library.contents.length);

    return Text(Localisation.nombreArticle(nombreArticle), style: const DsfrTextStyle.bodyLgBold());
  }
}

class _SliverListe extends StatelessWidget {
  const _SliverListe();

  @override
  Widget build(final context) {
    final contenus = context.select<LibraryBloc, List<Recommandation>>((final value) => value.state.library.contents);

    return contenus.isEmpty
        ? SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            spacing: DsfrSpacings.s3w,
            children: [
              FnvSvg.asset(AssetImages.bibliothequeEmpty),
              const Text(Localisation.bibliothequeAucunArticle, style: DsfrTextStyle.headline4()),
            ],
          ),
        )
        : SliverList.separated(
          itemBuilder: (final context, final index) => LibraryContent(content: contenus[index]),
          separatorBuilder: (final context, final index) => const SizedBox(height: DsfrSpacings.s2w),
          itemCount: contenus.length,
        );
  }
}
