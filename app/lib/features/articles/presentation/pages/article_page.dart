import 'package:app/core/helpers/string.dart';
import 'package:app/core/presentation/widgets/composants/app_bar.dart';
import 'package:app/core/presentation/widgets/composants/html_widget.dart';
import 'package:app/core/presentation/widgets/composants/image.dart';
import 'package:app/core/presentation/widgets/composants/scaffold.dart';
import 'package:app/core/source/sources_widget.dart';
import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/articles/presentation/bloc/article_bloc.dart';
import 'package:app/features/articles/presentation/bloc/article_event.dart';
import 'package:app/l10n/l10n.dart';
import 'package:dsfr/dsfr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key, required this.id});

  static const name = 'article';
  static const path = 'article/:title/:id';

  static Map<String, String> pathParameters({
    // Le titre est uniquement ajouté pour être iso avec le web et permettre le deeplink
    final String title = 'titre-action',
    required final String id,
  }) => {'title': title, 'id': id};

  static GoRoute get route =>
      GoRoute(path: path, name: name, builder: (final context, final state) => ArticlePage(id: state.pathParameters['id']!));

  final String id;

  @override
  Widget build(final BuildContext context) => FnvScaffold(
    appBar: FnvAppBar(),
    body: BlocProvider(
      create: (final context) => ArticleBloc(articlesRepository: context.read())..add(ArticleRecuperationDemandee(id)),
      child: const _Content(),
    ),
  );
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(final BuildContext context) {
    final article = context.select<ArticleBloc, Article>((final v) => v.state.article);

    return SingleChildScrollView(
      child: Column(
        spacing: DsfrSpacings.s2w,
        children: [
          Padding(
            padding: const EdgeInsets.all(DsfrSpacings.s2w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(article.titre, style: const DsfrTextStyle.headline2()),
                if (article.sousTitre != null && article.sousTitre!.isNotEmpty) ...[
                  const SizedBox(height: DsfrSpacings.s2w),
                  Text(article.sousTitre!, style: const DsfrTextStyle.headline6()),
                ],
                const SizedBox(height: DsfrSpacings.s2w),
                FnvHtmlWidget(article.contenu),
                if (article.partner != null) ...[
                  const SizedBox(height: DsfrSpacings.s4w),
                  const Text(Localisation.proposePar, style: DsfrTextStyle.bodySm()),
                  const SizedBox(height: DsfrSpacings.s1w),
                  _LogoWidget(article: article),
                ],
                if (article.sources.isNotEmpty) ...[
                  const SizedBox(height: DsfrSpacings.s2w),
                  SourcesWidget(sources: article.sources),
                ],
              ],
            ),
          ),
          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(DsfrSpacings.s2w),
              child: Column(
                spacing: DsfrSpacings.s2w,
                children: [
                  _FavoriteButton(isFavorite: article.isFavorite),
                  DsfrButton(
                    label: Localisation.partagerLArticle,
                    icon: DsfrIcons.systemShareLine,
                    iconLocation: DsfrButtonIconLocation.right,
                    variant: DsfrButtonVariant.tertiary,
                    size: DsfrComponentSize.lg,
                    onPressed: () async {
                      final uri = Uri.parse(
                        'https://jagis.beta.gouv.fr/article/${titleToKebabCase(article.titre)}/${article.id}',
                      );
                      await SharePlus.instance.share(ShareParams(uri: uri));
                    },
                  ),
                  const SafeArea(child: SizedBox(height: DsfrSpacings.s2w)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite});

  final bool isFavorite;

  @override
  Widget build(final BuildContext context) {
    const iconLocation = DsfrButtonIconLocation.right;
    const variant = DsfrButtonVariant.tertiary;
    const size = DsfrComponentSize.lg;

    if (isFavorite) {
      return DsfrButton(
        label: Localisation.retirerDesFavoris,
        icon: DsfrIcons.healthHeartFill,
        iconLocation: iconLocation,
        iconColor: DsfrColors.redMarianneMain472,
        variant: variant,
        size: size,
        onPressed: () => context.read<ArticleBloc>().add(const ArticleRemoveToFavoritesPressed()),
      );
    }

    return DsfrButton(
      label: Localisation.ajouterEnFavoris,
      icon: DsfrIcons.healthHeartLine,
      iconLocation: iconLocation,
      variant: variant,
      size: size,
      onPressed: () => context.read<ArticleBloc>().add(const ArticleAddToFavoritesPressed()),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget({required this.article});

  final Article article;

  @override
  Widget build(final BuildContext context) {
    if (article.partner == null) {
      return const SizedBox.shrink();
    }

    final partner = article.partner!;
    final logoUrl = partner.logo;
    final logoName = partner.name;

    return FnvImage.network(logoUrl, semanticLabel: logoName);
  }
}
