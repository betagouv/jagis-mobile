import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract final class Localisation {
  const Localisation._();

  static const accederAuCatalogue = 'Accéder au catalogue';
  static const accederAuSimulateur = 'Accéder au simulateur';
  static const acheterUnVelo = 'Acheter un vélo';
  static const actionBravo = 'Bravo ! 🎉';
  static const actionPerformanceTerminePart1 = 'Vous avez terminé votre bilan ! Il est de ';
  static const actions = 'Actions';
  static const actionsRealiseesEnFrance = 'Actions réalisées ensemble partout en France';
  static const adresseEmail = 'Mon adresse email';
  static const adresseEmailHint = 'Format attendu : nom@domaine.fr';
  static const adultes = 'Adulte(s)';
  static const affinezVosRecommandations = 'Affinez vos recommandations';
  static const affinezVosRecommandationsDetails = 'Répondez à quelques questions rapides sur le thème de votre choix';
  static const aidListTitle = '**Aides financières** et bons plans **chez vous**';
  static const aideVeloAvertissement = 'Veuillez compléter ces informations afin de débuter l’estimation';
  static const aides = 'Aides';
  static const aidesEtBonsPlans = 'Aides et bons plans !';
  static const ajouterEnFavoris = 'Ajouter en favoris';
  static const annuler = 'Annuler';
  static const appEstEncoreEnExperimentation = 'J’agis est encore en expérimentation !';
  static const appEstEncoreEnExperimentationDetails = 'Nous ajoutons progressivement les aides et contenus locaux à ';
  static const appEstEncoreEnExperimentationDetails2 = '\nRevenez régulièrement pour profiter de nos dernières nouveautés';
  static const attentionAucuneDonneeNePourraEtreRecuperee = 'Attention, aucune donnée ne pourra être récupérée.';
  static const aucuneActionTrouvee = 'Aucune action trouvée';
  static const aucuneAideDisponible = 'Aucune aide\ndisponible';
  static const aucuneDeCesPropositions = 'Aucune de ces propositions';
  static const avecMonAdresseEmail = 'Avec mon adresse email';
  static const avezVousAimeCettePage = 'Avez-vous aimé cette page ?';
  static const avezVousAimeCettePageDescription =
      'Vos retours sont précieux et façonnent ce service. Partagez-nous vos impressions, nous nous efforcerons d’y répondre prochainement.';
  static const avezVousAimeCettePageSnackBar =
      'Merci pour votre retour ! Notre équipe en prendra connaissance très prochainement';
  static const besoinDInspiration = 'Besoin **d’inspiration** ?';
  static const bibliotheque = 'Bibliothèque';
  static const bibliothequeAucunArticle = 'Aucun article trouvé';
  static const bibliothequeSousTitre = 'Retrouver ici vos articles déjà consultés ainsi que vos favoris';
  static const bienvenueSur = 'Bienvenue sur J’agis ! Faisons connaissance…';
  static const bienvenueSurDetails = 'Nous avons quelques questions à vous poser pour personnaliser votre expérience !';
  static const bonjour = 'Bonjour,';
  static String bonjourPseudonym(final String pseudonym) => 'Bonjour $pseudonym,';

  static const empreinteEcologique = 'Empreinte écologique';
  static const catalogueActions = 'Catalogue d’actions';
  static const cestParti = 'C’est parti !';
  static const cestPresqueTermine = 'C’est presque terminé !';
  static const choisirCommeAdressePrincipale = 'Enregistrer';
  static const choisirCommeAdressePrincipaleDescription =
      'Pratique : souhaitez-vous enregistrer votre adresse principale pour une prochaine fois ?';
  static const choisissezUneAdresse = 'Choisissez une adresse';
  static const codeDeVerification = 'Code de vérification';
  static const codePostal = 'Code postal';
  static const combienEtesVousDansVotreLogement = 'Combien êtes-vous dans votre logement (vous inclus) ?';
  static const commencer = 'Commencer';
  static const commentPourrionsNousLAmeliorer = 'Comment pourrions-nous l’améliorer ?';
  static const commencerVotreDemarche = 'Commencer votre démarche';
  static const commune = 'Commune';
  static const confirmer = 'Confirmer';
  static const consommationsEnergetiques = 'Consommations énergétiques';
  static const continuer = 'Continuer';
  static const contributeursOpenStreetMap = 'Contributeurs OpenStreetMap';
  static const coutAnnuel = 'Coût annuel';
  static const creerMonCompte = 'Créer mon compte';
  static const creerUnCompte = 'Créer un compte';
  static const dateDeNaissance = 'Date de naissance';
  static const dateDeNaissanceDescription = 'Nécessaire pour faciliter votre identification';
  static const declarationAccessibilite = 'Déclaration d’accessibilité';
  static const declarationAccessibiliteSite = 'https://jagis.beta.gouv.fr/accessibilite';
  static const dejaConsultees = 'Déjà consultées';
  static const details = 'Détails';
  static const donneesPersonnelles = 'Données personnelles';
  static const donneesUtiliseesPart1 = 'Données utilisées : code postal ';
  static const donneesUtiliseesPart2 = ', revenu fiscal de référence ';
  static const donneesUtiliseesPart3 = ', nombre de parts ';
  static const dpeA = 'A';
  static const dpeB = 'B';
  static const dpeC = 'C';
  static const dpeD = 'D';
  static const dpeE = 'E';
  static const dpeExplication = '**Qu’est-ce qu’un DPE ?**';
  static const dpeExplicationDetails =
      'Le DPE, c’est le **Diagnostic de Performance Énergétique de votre logement**. Il mesure d’un côté l’énergie nécessaire pour y maintenir une température standard, et de l’autre l’empreinte climat associée. Le DPE est exprimé comme une note de A (très bon) à G (passoire thermique). Vous pouvez obtenir une estimation de votre DPE en 2 clics avec le service [Go Renov](https://particulier.gorenove.fr/).';
  static const dpeF = 'F';
  static const dpeG = 'G';
  static const dpeJeNeSaisPas = 'Je ne sais pas';
  static const elementsNecessaireAuCalcul = 'Éléments nécessaires au calcul';
  static const emissionsAnnuelles = 'Émissions annuelles';
  static const enchante = 'Enchanté, ';
  static const enchanteDetails =
      'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.';
  static const enfants = 'Enfant(s) de moins de 18 ans';
  static const enSavoirPlus = 'En savoir plus';
  static const entre100et150m2 = 'Entre 100 et 150 m²';
  static const entre35et70m2 = 'Entre 35 et 70 m²';
  static const entre70et100m2 = 'Entre 70 et 100 m²';
  static const entrezLeCodeRecuParMail = 'Entrez le code reçu par e-mail !';
  static const envieDeVoirOuRevoirToutesLesActions = 'Envie de voir ou revoir toutes les actions ?';
  static const envoyer = 'Envoyer';
  static const erreurInattendue = 'Erreur inattendue';
  static const erreurInattendueContent =
      'Désolé, le service rencontre un problème, nous y travaillons pour le résoudre le plus rapidement possible.';
  static const erreurRoutePageAction = 'Page d’accueil';
  static const erreurRoutePageDescription = 'La page est introuvable. Excusez-nous pour la gêne occasionnée.';
  static const erreurRoutePageTitre = 'Page non trouvée';
  static const estimerMesAides = 'Estimer mes aides';
  static const etapes = 'Étapes';
  static const etatDuVelo = 'État du vélo';
  static const etesVousEnSituationDeHandicap = 'Êtes-vous en situation de handicap ?';
  static const euroSymbol = '€';
  static const facultatif = 'facultatif';
  static const fermer = 'Fermer';
  static const franceConnectDescription =
      'FranceConnect est la solution proposée par l’État pour sécuriser et simplifier la connexion à vos services en ligne.';
  static const franceConnectEnSavoirPlus = 'Qu’est-ce que FranceConnect ?';
  static const franceConnectEnSavoirPlusUrl = 'https://franceconnect.gouv.fr';
  static const franceConnectPrefix = 'S’identifier avec';
  static const franceConnectTitle = 'Utiliser FranceConnect';
  static const fruits = 'Fruits';
  static const fruitsEtLegumesConsommateurs = 'Consommateurs';
  static const fruitsEtLegumesConsommateursDescription = 'Plus de 5 kg CO₂e par kg';
  static const fruitsEtLegumesMoyennementConsommateurs = 'Moyennement consommateurs';
  static const fruitsEtLegumesMoyennementConsommateursDescription = 'Entre 1 et 5 kg CO₂e par kg';
  static const fruitsEtLegumesPeuConsommateurs = 'Peu consommateurs';
  static const fruitsEtLegumesPeuConsommateursDescription = 'Moins de 1 kg CO₂e par kg';
  static const fruitsEtLegumesTitre = 'Les fruits et légumes pour le mois de ';
  static const gratuit = 'Gratuit';
  static const home = 'Accueil';
  static const ilEstTempsDAgirChoisissezVotreProchaineAction = 'Il est temps d’agir, choisissez votre prochaine action !';
  static const ilYADuNouveauSurApp = 'Il y a du nouveau sur J’agis !';
  static const ilYADuNouveauSurAppDescription = '''
Nous avons écouté vos retours et concocté une toute **nouvelle version** du service.

**Personnalisez votre expérience** en quelques questions et obtenez des **idées d’actions** concrètes, avec tous les **outils**, **adresses** et **aides financières** pour y arriver !''';
  static const impactCo2 = 'Impact CO₂';
  static const impactCo2Description = 'Des informations fiables et sourcées issues des données environnementales de l’ADEME';
  static const impactCo2Url = 'https://impactco2.fr';
  static const ingredients = 'Ingrédients';
  static const jaiCompris = 'J’ai compris';
  static const jaiDejaUnCompte = 'J’ai déjà un compte';
  static const jaiReleveLeDefi = 'J’ai relevé le défi !';
  static const jeCreeMonCompte = 'Je crée mon compte';
  static const jusqua = 'Jusqu’à ';
  static const kgCO2e = 'kgCO2e';
  static const laPlusEcologique = 'La plus écologique';
  static const laPlusEconomique = 'La plus économique';
  static const leServiveNeCouvrePasEncoreVotreVille = 'Le service ne couvre pas encore votre ville.';
  static const leServiveNeCouvrePasEncoreVotreVilleDescription = 'Nous mettons les informations à jour progressivement.';
  static const legumes = 'Légumes';
  static const lesCategories = 'Les catégories';
  static const lesCguMenu = 'CGU';
  static const lesCguSite = 'https://jagis.beta.gouv.fr/cgu';
  static const lesCguTitrePart1 = 'En m’inscrivant j’accepte les ';
  static const lesCguTitrePart2 = 'Conditions générales d’utilisation';
  static const lesMeilleuresAlternativesPourLeGabarit = 'Les meilleures alternatives pour le gabarit ';
  static const localiserMonCompteur = 'Localiser mon compteur';
  static const lvaoDescription =
      'L’ADEME vous aide à prolonger la vie de vos objets. Pour préserver les ressources de la planète… et de votre porte-monnaie !';
  static const lvaoNom = 'Que faire de mes objets - ADEME';
  static const lvaoSousTitre = 'Redonnez vie à vos objets et trouvez les nouveaux en seconde main';
  static const lvaoUrl = 'https://quefairedemesobjets.ademe.fr';
  static const maDateDeNaissance = 'Ma date de naissance';
  static const maReponse = 'Ma réponse';
  static const maResidencePrincipaleEst = 'Ma résidence principale est …';
  static const maifDescription =
      'Exposition aux risques climatiques, services de proximité, prix de l’immobilier… Retrouvez toutes les informations utiles aux alentours de votre adresse !';
  static const maifNom = 'Aux Alentours par MAIF';
  static const maifUrl = 'https://auxalentours.maif.fr';
  static const mangerBougerDescription = 'Pour vous aider jour après jour à manger varié et équilibré.';
  static const mangerBougerNom = 'La fabrique à Menus';
  static const mangerBougerUrl = 'https://www.mangerbouger.fr/manger-mieux/la-fabrique-a-menus';
  static const pdcnSousTitre = 'Produits locaux, bio, de saisons et vendeurs de vrac, pour une cuisine savoureuse et responsable';
  static const pdcnDescription =
      'Près de chez nous est une cartographie collaborative qui recense l’ensemble des structures qui proposent des produits bio, équitables et locaux.';
  static const pdcnNom = 'Près de chez nous';
  static const pdcnUrl = 'https://presdecheznous.fr';
  static const meConnecter = 'Me connecter';
  static const mentionsLegales = 'Mentions légales';
  static const mentionsLegalesSite = 'https://jagis.beta.gouv.fr/mentions-legales';
  static const menu = 'Menu';
  static const merciPourVotreSoutien = 'Merci pour votre soutien !';
  static const merciPourVotreSoutienDescription = '''
Vous avez fait partie des **premiers utilisateurs** à tester ce nouveau service, à nous faire vos retours, et nous permettre de nous améliorer.

Pour cela, nous aimerions vous remercier avec **ce badge** et 200 feuilles pour commencer cette **nouvelle aventure…**''';
  static const mesActionsRecommandeesEpuiseeDescription =
      'Chaque mois, J’agis s’enrichit en nouveautés pour vous proposer toujours plus d’actions qui vous correspondent.';
  static const mesActionsRecommandeesEpuiseeTitre = 'C’est tout, pour le moment';
  static const mesAidesDisponibles = 'Mes aides disponibles';
  static const mesBadges = 'Mes badges';
  static const mesCommerces = 'Mes commerces';
  static const mesFavoris = 'Mes favoris';
  static const mesInformations = 'Mes informations';
  static const mesInformationsAdresseEmail = 'Adresse e-mail : ';
  static const mettreAJour = 'Mettre à jour';
  static const mettreAJourMesInformations = 'Mettre à jour mes informations';
  static const mieuxComprendreVosHabitudes = 'Mieux comprendre vos habitudes';
  static const mieuxVousConnaitre = 'Mieux vous connaître';
  static const miseAJourEffectuee = 'Mise à jour effectuée';
  static const modifier = 'Modifier';
  static const moinsDe35m2 = 'Moins de 35 m²';
  static const monAdresse = 'Mon adresse';
  static const monClassement = 'Mon classement';
  static const monEmpreinteEcologique = 'Mon empreinte écologique';
  static const monIdentite = 'Mon identité';
  static const monLogement = 'Mon logement';
  static const monLogementPlusDe15Ans = 'Mon logement a-t-il plus de 15 ans ?';
  static const monProfil = 'Mon profil';
  static const monPseudonyme = 'Mon pseudonyme';
  static const monPseudonymeIndice = 'Doit être composés de 3 à 21 caractères. Lettres et chiffres uniquement.';
  static const nom = 'Nom';
  static const nomDeFamille = 'Nom de famille (du titulaire du contrat électrique)';
  static const nombreDePartsFiscales = 'Nombre de parts fiscales de votre foyer';
  static const nombreDePartsFiscalesDescription = '(Pré-calculé à partir des membres de votre foyer)';
  static const non = 'Non';
  static const nousPreparonsVosRecommandationsPersonnalisees = 'Nous préparons vos recommandations personnalisées…';
  static const obligatoire = 'obligatoire';
  static const onRepondAVosQuestions = 'On répond à vos questions !';
  static const onSeLanceLeDefi = 'On se lance le défi ?';
  static const optionsAvancees = 'Options avancées';
  static const ouHabitezVous = 'Où habitez-vous ?';
  static const ouTrouverCesInformations = 'Où trouver ces informations ?';
  static const ouTrouverCesInformationsReponse = '''
Le revenu fiscal de référence et votre nombre de parts se trouvent sur la 1ère page de votre dernier avis d’impôt.

**Nombre de parts :**

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez 1 part pour chaque adulte de votre foyer fiscal, puis 0,5 part par enfant jusqu’à 2 enfants, puis 1 part par enfant à partir du 3ème enfant.

**Revenu fiscal de référence :**

Si vous ne disposez pas de votre dernier avis d’impôt, renseignez la somme des revenus de toutes les personnes avec lequelles vous partagez vos déclarations d’impôts (pour toute l’année) pour vous faire une première idée.''';
  static const oui = 'Oui';
  static const pageConnexionTitre = 'Connexion à *J’agis*';
  static const partagerLArticle = 'Partager l’article';
  static const passerLaQuestion = 'Passer la question';
  static const pionnier = 'Pionnier';
  static const pionnierDescription = 'Présent depuis les premiers jours';
  static const plusDe150m2 = 'Plus de 150 m²';
  static const plusieursReponsesPossibles = 'Plusieurs réponses possibles';
  static const point = '.';
  static const politiqueDeConfidentialite = 'Politique de confidentialité';
  static const politiqueDeConfidentialiteSite = 'https://jagis.beta.gouv.fr/politique-de-confidentialite';
  static const posezVotreQuestion = 'Posez votre question';
  static const posezVotreQuestionSnackBar = 'Merci pour votre question ! Notre équipe en prendra connaissance très prochainement';
  static const notreEquipeVousRepond = ', notre équipe vous répond !';
  static const posezVotreQuestionDescription =
      'Une question ou une difficulté pour réaliser cette action ?\nNotre équipe vous répondra par email !';
  static const pourquoiCesQuestions = 'Pourquoi ces questions ?';
  static const pourquoiCesQuestionsReponse =
      'Votre revenu fiscal de référence et le nombre de parts permettent d’afficher les aides en fonction de vos ressources.';
  static const preOnboardingTitre = 'Ensemble, améliorons nos habitudes au jour le jour';
  static const prenom = 'Prénom';
  static const prixDuVelo = 'Prix du vélo';
  static const prixDuVeloExplications = 'À titre indicatif, voici quelques prix moyens';
  static const prixDuVeloObligatoire = 'Le prix du vélo ne peux pas être vide';
  static const proposePar = 'Proposé par';
  static const proposerUneModification = 'Proposer une modification';
  static const propulsePar = 'Propulsé par ';
  static const pseudonymEmpty = 'Le pseudonyme ne peut pas être vide.';
  static const pseudonymInvalid = 'Le pseudonyme n’est pas valide.';
  static const pseudonyme = 'Pseudonyme';
  static const quelleEstLaSuperficie = 'Quelle est la superficie ?';
  static const questionPrecedente = 'Question précédente';
  static const questionSuivante = 'Question suivante';
  static const quoiDeNeuf = 'Quoi de neuf ?';
  static const pourAllerPlusLoin = 'Pour aller **plus loin**';
  static const raccourcis = 'Raccourcis';
  static const rafraichir = 'Rafraichir';
  static const recettes = 'Recettes';
  static const rechargeElectriqueQuestion = 'J’ai la possibilité de recharger un véhicule électrique au quotidien.';
  static const rechercherParAdresse = 'Rechercher par adresse';
  static const serviceAucunResultat = '😢 Aucun résultat n’est encore disponible pour votre localisation';
  static const rechercherParTitre = 'Rechercher par titre';
  static const recolter = 'Récolter';
  static const recommandees = 'Recommandées';
  static const recommencerLeBilan = 'Recommmencer le bilan';
  static const recommencerLeQuiz = 'Recommencer le quiz';
  static const refaire = 'Refaire';
  static const reponse = 'Réponse';
  static const retentezVotreChancePourValiderCetteAction = 'Retentez votre chance pour valider cette action.';
  static const retirerDesFavoris = 'Retirer des favoris';
  static const retour = 'Retour';
  static const revenirALaThematique = 'Revenir à la thématique';
  static const revenirAuCatalogue = 'Revenir au catalogue';
  static const revenirAuSimulateur = 'Revenir au simulateur';
  static const revenuFiscal = 'Revenu fiscal de référence de mon foyer';
  static const revenuQuestion = 'Quelle est votre tranche de revenus ?';
  static const santePubliqueFrance = '© Santé publique France';
  static const seDeconnecter = 'Se déconnecter';
  static const simulateur = 'Simulateur';
  static const simulerMonAide = 'Simuler mon aide';
  static const sources = 'Sources :';
  static const statistiques = 'Statistiques';
  static const statistiquesSite = 'https://jagis.beta.gouv.fr/statistiques';
  static const suggestions = 'Suggestions';
  static const supprimerVotreCompte = 'Supprimer mon compte';
  static const jePrefereRentrerLeCodeManuellement = 'Je préfère rentrer le code manuellement';
  static const supprimerVotreCompteConfirmation = 'Veuillez confirmer la suppression du compte';
  static const supprimerVotreCompteContenu =
      'Vous pouvez à tout moment choisir de supprimer votre compte ainsi que l’ensemble des données qui y sont associées.';
  static const terminees = 'Terminées';
  static const tout = 'Tout';
  static const toutEstPret = 'Tout est prêt !';
  static const unAppartement = 'Un appartement';
  static const uneMaison = 'Une maison';
  static const valider = 'Valider';
  static const verifiezVotreBoiteEmail = 'Vérifiez votre boîte e-mail';
  static const voirLaReponse = 'Voir la réponse';
  static const voirLeResultat = 'Voir le résultat';
  static const voirLesDemarches = 'Voir les démarches';
  static const voirMesResultats = 'Voir mes résultats';
  static const voirTout = 'Voir tout';
  static const vosRisques = 'Vos risques';
  static const voirToutesLesRecettes = 'Voir toutes les recettes';
  static const votreVehiculeActuel = 'Votre véhicule actuel';
  static const vousAvezDejaFaitCeSimulateur = 'Vous avez déjà fait ce simulateur';
  static const vousAvezDejaLOptionLaPlusEcologique = 'Vous avez déjà l’option la plus écologique !';
  static const vousAvezDejaLOptionLaPlusEconomique = 'Vous avez déjà l’option la plus économique !';
  static const vousAvezObtenuUnScoreKoDe = '😬 Vous avez obtenu un score de';
  static const vousAvezObtenuUnScoreOkDe = '👏 Vous avez obtenu un score de';
  static const vousAvezTermineLeQuiz = 'Vous avez terminé le quiz';
  static const vousEtesProprietaireDeVotreLogement = 'Vous êtes propriétaire de votre logement ?';
  static const winterTitre = 'Réduisez jusqu’à 25% votre facture d’énergie';
  static const winterDescription =
      'En nous renseignant votre adresse et en répondant à quelques questions sur votre logement, découvrez vos postes les plus gourmands en énergie et les astuces pour réduire leur consommation !';
  static const winterJeDeclare =
      'En activant le suivi de ma consommation, je déclare sur l’honneur être titulaire du compte électrique ou être mandaté par celui-ci. J’autorise Watt Watchers à recueillir mon historique de consommation d’électricité sur 3 ans (demi-heure, journée et puissance maximum quotidienne), ainsi qu’à analyser mes consommations.';
  static String a(final String value) => 'à $value';
  static String actionPerformanceTerminePart2(final String value) => '$value tonnes';
  static String actionPerformanceTerminePart3(final String value) => ' de CO₂e par an pour votre $value';
  static String actionPerformanceTermineTitle(final String value) => 'Votre bilan $value';
  static String cacherEmail(final String email) {
    final indexArobase = email.characters.findFirst(Characters('@'))!.stringBeforeLength;

    if (indexArobase > 2) {
      final debut = email.characters.getRange(0, 1);
      final fin = email.characters.getRange(indexArobase - 1, email.length);

      return '$debut${'*' * (indexArobase - 1 - 1)}$fin';
    }

    return email;
  }

  static String communeEtSaRegion(final String commune) => '$commune et sa région.';

  static String distance(final int value) =>
      value >= 1000 ? 'À ${NumberFormat('0.#', 'fr').format(value / 1000)} km' : 'À $value m';

  static String donneesUtiliseesCodePostalEtCommune({required final String codePostal, required final String commune}) =>
      '($codePostal - $commune)';

  static String donneesUtiliseesNombreDeParts(final double value) => '($value)';

  static String donneesUtiliseesRevenuFiscal(final int? value) => '(${value == null ? '' : '$value €'})';

  static String entrezLeCodeRecuParMailDetails(final String value) =>
      'Pour vérifier votre identité et vous permettre d’accéder à votre compte, nous vous avons envoyé un e-mail à l’adresse : ${cacherEmail(value)}';

  static String lesChiffresClesDe(final String city) => 'Les chiffres clés de **$city**';

  static String nombreAction(final int value) => value <= 1 ? '$value action' : '$value actions';

  static String nombreArticle(final int value) => value <= 1 ? '$value article' : '$value articles';

  static String nombreBadges(final int value) => value <= 1 ? '$value badge' : '$value badges';

  static String nombrePoints(final int value) => value <= 1 ? '$value point' : '$value points';

  static String questionPour(final int max) => '$max questions pour…';
  static String questionCourantSurMax(final int actuel, final int max) => '**Question $actuel** sur $max';

  static String tempsDePreparation(final int value) => 'Temps de préparation : $value min';

  static String veloLabel(final String text) => '$text : ';

  static String verifiezVotreBoiteEmailDescription(final String email) =>
      'Un lien de connexion vous a été envoyé à l’adresse : **$email** pour vous permettre d’accéder à votre compte';

  static String votreReponse(final bool isCorrect) => '${isCorrect ? '✅' : '❌'} Votre réponse : ';
}
