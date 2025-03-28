import 'package:app/features/theme/core/domain/theme_type.dart';
import 'package:equatable/equatable.dart';

class Recommandation extends Equatable {
  const Recommandation({
    required this.id,
    required this.titre,
    required this.sousTitre,
    required this.imageUrl,
    required this.thematique,
  });

  final String id;
  final String titre;
  final String? sousTitre;
  final String imageUrl;
  final ThemeType thematique;

  @override
  List<Object?> get props => [id, titre, sousTitre, imageUrl, thematique];
}
