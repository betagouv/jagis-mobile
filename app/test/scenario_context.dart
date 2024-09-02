import 'package:app/features/aides/domain/entities/aide.dart';
import 'package:app/features/aides/simulateur_velo/domain/value_objects/aide_velo_par_type.dart';
import 'package:app/features/articles/domain/article.dart';
import 'package:app/features/authentification/domain/value_objects/authentification_statut.dart';
import 'package:app/features/bibliotheque/domain/bibliotheque.dart';
import 'package:app/features/gamification/domain/gamification.dart';
import 'package:app/features/mieux_vous_connaitre/domain/question.dart';
import 'package:app/features/profil/logement/presentation/blocs/mon_logement_state.dart';
import 'package:app/features/quiz/domain/quiz.dart';
import 'package:app/features/recommandations/domain/recommandation.dart';
import 'package:app/features/univers/domain/aggregates/mission.dart';
import 'package:app/features/univers/domain/entities/defi.dart';
import 'package:app/features/univers/domain/mission_liste.dart';
import 'package:app/features/univers/domain/tuile_univers.dart';
import 'package:app/features/univers/domain/value_objects/defi_id.dart';

import 'mocks/aide_velo_port_mock.dart';
import 'mocks/articles_port_mock.dart';
import 'mocks/authentification_port_mock.dart';
import 'mocks/mieux_vous_connaitre_port_mock.dart';
import 'mocks/profil_port_mock.dart';
import 'mocks/quiz_port_mock.dart';
import 'mocks/univers_port_mock.dart';

class ScenarioContext {
  factory ScenarioContext() => _instance ??= ScenarioContext._();
  ScenarioContext._();
  AuthentificationStatut authentificationStatut =
      AuthentificationStatut.pasConnecte;
  String prenom = 'Lucas';
  String nom = 'Saudon';
  String email = 'lucas@saudon.fr';
  String codePostal = '75018';
  String commune = 'Paris';
  int nombreAdultes = 1;
  int nombreEnfants = 0;
  TypeDeLogement? typeDeLogement;
  bool? estProprietaire;
  Superficie? superficie;
  Chauffage? chauffage;
  bool? plusDe15Ans;
  Dpe? dpe;
  double nombreDePartsFiscales = 0;
  int? revenuFiscal;
  bool estIntegrationTerminee = true;
  AideVeloParType aideVeloParType = const AideVeloParType(
    mecaniqueSimple: [],
    electrique: [],
    cargo: [],
    cargoElectrique: [],
    pliant: [],
    motorisation: [],
  );
  List<Aide> aides = <Aide>[];
  List<MissionListe> missionListe = <MissionListe>[];
  Mission mission = const Mission(
    titre: '',
    imageUrl: '',
    kycListe: [],
    quizListe: [],
    articles: [],
    defis: [],
    peutEtreTermine: false,
    estTermine: false,
  );
  Defi defi = const Defi(
    id: DefiId(''),
    thematique: '',
    titre: '',
    status: '',
    astuces: '',
    pourquoi: '',
  );
  List<Recommandation> recommandations = <Recommandation>[];
  Article article = const Article(
    titre: 'Titre',
    sousTitre: 'Sous-titre',
    contenu: '<p>Contenu</p>',
    partenaire: null,
  );
  Quiz quiz = const Quiz(
    id: 0,
    thematique: '',
    question: '',
    reponses: [],
    points: 0,
    explicationOk: '',
    explicationKo: '',
    article: null,
  );
  List<String> communes = <String>[];
  List<Question> questions = <Question>[];
  Bibliotheque bibliotheque = const Bibliotheque(contenus: [], filtres: []);
  Gamification gamification = const Gamification(points: 0);
  List<TuileUnivers> tuileUnivers = <TuileUnivers>[];

  AideVeloPortMock? aideVeloPortMock;
  ProfilPortMock? profilPortMock;
  ArticlesPortMock? articlesPortMock;
  AuthentificationPortMock? authentificationPortMock;
  QuizPortMock? quizPortMock;
  MieuxVousConnaitrePortMock? mieuxVousConnaitrePortMock;
  UniversPortMock? universPortMock;
  static ScenarioContext? _instance;

  void dispose() => _instance = null;
}
