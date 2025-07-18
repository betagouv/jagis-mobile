import 'package:app/core/source/source.dart';
import 'package:app/features/articles/domain/partner.dart';
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  const Article({
    required this.id,
    required this.imageUrl,
    required this.titre,
    required this.sousTitre,
    required this.contenu,
    required this.partner,
    required this.sources,
    required this.isFavorite,
    required this.isRead,
  });

  final String id;
  final String imageUrl;
  final String titre;
  final String? sousTitre;
  final String contenu;
  final Partner? partner;
  final List<Source> sources;
  final bool isFavorite;
  final bool isRead;

  Article copyWith({
    final String? id,
    final String? imageUrl,
    final String? titre,
    final String? sousTitre,
    final String? contenu,
    final Partner? partner,
    final List<Source>? sources,
    final bool? isFavorite,
    final bool? isRead,
  }) => Article(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    titre: titre ?? this.titre,
    sousTitre: sousTitre ?? this.sousTitre,
    contenu: contenu ?? this.contenu,
    partner: partner ?? this.partner,
    sources: sources ?? this.sources,
    isFavorite: isFavorite ?? this.isFavorite,
    isRead: isRead ?? this.isRead,
  );

  @override
  List<Object?> get props => [id, imageUrl, titre, sousTitre, contenu, partner, sources, isFavorite, isRead];
}
