// ignore_for_file: prefer-correct-callback-field-name

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
  static const aidListTitle = '**Aides financières** et bons plans **chez vous**';
  static const aide = 'aide';
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
  static const bilanEnvironnemental = 'Bilan environnemental';
  static const bonjour = 'Bonjour,\n';
  static const catalogueActions = 'Catalogue d’actions';
  static const cestParti = 'C’est parti !';
  static const cestPresqueTermine = 'C’est presque terminé !';
  static const changerMonMotDePasse = 'Changer mon mot de passe';
  static const changerVotreMotDePasseConfirmation = 'Votre mot de passe a été changé.';
  static const codeDeVerification = 'Code de vérification';
  static const codePostal = 'Code postal';
  static const combienEtesVousDansVotreLogement = 'Combien êtes-vous dans votre logement (vous inclus) ?';
  static const commencer = 'Commencer';
  static const commentPourrionsNousLAmeliorer = 'Comment pourrions-nous l’améliorer ?';
  static const commencerVotreDemarche = 'Commencer votre démarche';
  static const commune = 'Commune';
  static const completer = 'Compléter';
  static const confirmer = 'Confirmer';
  static const consommationsEnergetiques = 'Consommations énergétiques';
  static const continuer = 'Continuer';
  static const coutAnnuel = 'Coût annuel';
  static const creerMonCompte = 'Créer mon compte';
  static const creerMonCompteApp = 'Créez votre compte J’agis';
  static const dansQuelDomaineSouhaitezVousAgir = 'Dans quel domaine\nsouhaitez-vous agir ?';
  static const dateDeNaissance = 'Date de naissance';
  static const dateDeNaissanceDescription = 'Nécessaire pour faciliter votre identification';
  static const declarationAccessibilite = 'Déclaration d’accessibilité';
  static const declarationAccessibiliteSite = 'https://jagis.beta.gouv.fr/accessibilite';
  static const dejaConsultees = 'Déjà consultées';
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
  static const emailDeConnexionRenvoye = 'Email de connexion renvoyé';
  static const emissionsAnnuelles = 'Émissions annuelles';
  static const enchante = 'Enchanté, ';
  static const enchanteDetails =
      'Pour découvrir des aides, services et contenus disponibles proches de chez vous, indiquez-nous votre lieu de résidence.';
  static const enfants = 'Enfant(s) de moins de 18 ans';
  static const entre100et150m2 = 'Entre 100 et 150 m²';
  static const entre35et70m2 = 'Entre 35 et 70 m²';
  static const entre70et100m2 = 'Entre 70 et 100 m²';
  static const entrezLeCodeRecuParMail = 'Entrez le code reçu par e-mail !';
  static const envieDAvoirUnVraiImpact = 'Envie d’avoir un vrai impact ?';
  static const envieDAvoirUnVraiImpactDescription =
      'Laissez-vous guider par nos recommandations d’actions **choisies pour vous !**';
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
  static const franceConnect = 'FranceConnect';
  static const franceConnectDescription =
      'FranceConnect est la solution proposée par l’État pour sécuriser et simplifier la connexion à vos services en ligne.';
  static const franceConnectEnSavoirPlus = 'Qu’est-ce que FranceConnect ?';
  static const franceConnectEnSavoirPlusUrl = 'https://franceconnect.gouv.fr/';
  static const franceConnectPrefix = 'S’identifier avec';
  static const franceConnectTitle = 'Utilisez FranceConnect';
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
  static const ilYADuNouveauSurApp = 'Il y a du nouveau sur J’agis !';
  static const ilYADuNouveauSurAppDescription = '''
Nous avons écouté vos retours et concocté une toute **nouvelle version** du service.

**Personnalisez votre expérience** en quelques questions et obtenez des **idées d’actions** concrètes, avec tous les **outils**, **adresses** et **aides financières** pour y arriver !''';
  static const impactCo2 = 'Impact CO₂';
  static const impactCo2Description = 'Des informations fiables et sourcées issues des données environnementales de l’ADEME';
  static const impactCo2Url = 'https://impactco2.fr/';
  static const ingredients = 'Ingrédients';
  static const jaccepte = 'J’accepte ';
  static const jaiCompris = 'J’ai compris';
  static const jaiDejaUnCompte = 'J’ai déjà un compte';
  static const jaiReleveLeDefi = 'J’ai relevé le défi !';
  static const jeCreeMonCompte = 'Je crée mon compte';
  static const jusqua = 'Jusqu’à ';
  static const kgCO2e = 'kgCO2e';
  static const laPlusEcologique = 'La plus écologique';
  static const laPlusEconomique = 'La plus économique';
  static const leServiveNeCouvrePasEncoreVotreVille = 'Le service ne couvre pas encore votre ville.';
  static const leServiveNeCouvrePasEncoreVotreVilleDescription = 'Nous mettons les informations à jour progressivement.';
  static const legumes = 'Légumes';
  static const lesCategories = 'Les catégories';
  static const lesCgu = 'les conditions générales d’utilisation';
  static const lesCguMenu = 'CGU';
  static const lesCguSite = 'https://jagis.beta.gouv.fr/cgu';
  static const lesMeilleuresAlternativesPourLeGabarit = 'Les meilleures alternatives pour le gabarit ';
  static const maDateDeNaissance = 'Ma date de naissance';
  static const maReponse = 'Ma réponse';
  static const maResidencePrincipaleEst = 'Ma résidence principale est …';
  static const mangerBougerDescription = 'Pour vous aider jour après jour à manger varié et équilibré.';
  static const mangerBougerNom = 'La fabrique à Menus';
  static const mangerBougerUrl = 'https://www.mangerbouger.fr/manger-mieux/la-fabrique-a-menus/';
  static const meConnecter = 'Me connecter';
  static const mentionsLegales = 'Mentions légales';
  static const mentionsLegalesSite = 'https://jagis.beta.gouv.fr/mentions-legales';
  static const menu = 'Menu';
  static const merciPourVotreSoutien = 'Merci pour votre soutien !';
  static const merciPourVotreSoutienDescription = '''
Vous avez fait partie des **premiers utilisateurs** à tester ce nouveau service, à nous faire vos retours, et nous permettre de nous améliorer.

Pour cela, nous aimerions vous remercier avec **ce badge** et 200 feuilles pour commencer cette **nouvelle aventure…**''';
  static const mesActionsRecommandees = 'Mes actions recommandées';
  static const mesActionsRecommandeesDescription =
      'Afin d’obtenir vos actions personnalisées, pouvez-vous nous en dire un peu plus sur vous ?';
  static const mesActionsRecommandeesEpuiseeDescription =
      'Chaque mois, J’agis s’enrichit en nouveautés pour vous proposer toujours plus d’actions qui vous correspondent.';
  static const mesActionsRecommandeesEpuiseeTitre = 'C’est tout, pour le moment';
  static const mesAidesDisponibles = 'Mes aides disponibles';
  static const mesCommerces = 'Mes commerces';
  static const mesCommercesDescription =
      'Produits locaux, bio, de saisons et vendeurs de vrac, pour une cuisine savoureuse et responsable';
  static const mesFavoris = 'Mes favoris';
  static const mesInformations = 'Mes informations';
  static const mesInformationsAdresseEmail = 'Adresse e-mail : ';
  static const mesServices = 'Mes services';
  static const mettreAJour = 'Mettre à jour';
  static const mettreAJourMesInformations = 'Mettre à jour mes informations';
  static const mieuxVousConnaitre = 'Mieux vous connaître';
  static const miseAJourEffectuee = 'Mise à jour effectuée';
  static const modifier = 'Modifier';
  static const moinsDe35m2 = 'Moins de 35 m²';
  static const monBilanEnvironnemental = 'Mon bilan environnemental';
  static const monIdentite = 'Mon identité';
  static const monLogement = 'Mon logement';
  static const monLogementPlusDe15Ans = 'Mon logement a-t-il plus de 15 ans ?';
  static const monMotDePasseDoitContenir = 'Mon mot de passe doit contenir :';
  static const monProfil = 'Mon profil';
  static const monPseudonyme = 'Mon pseudonyme';
  static const motDePasse = 'Mot de passe';
  static const motDePasse12CaractresMinimum = '12 caractères minimum';
  static const motDePasse1CaractreSpecialMinimum = '1 caractère spécial minimum';
  static const motDePasse1ChiffreMinimum = '1 chiffre minimum';
  static const motDePasse1MajusculeEt1Minuscule = 'Au moins 1 majuscule et 1 minuscule';
  static const motDePasseOublie = 'Mot de passe oublié ?';
  static const motDePasseOublieDetails = 'Saisissez l’adresse électronique associé à votre compte.';
  static const motDePasseOublieTitre = 'Mot de passe oublié - 1/2';
  static const motDePasseOublieTitre2 = 'Mot de passe oublié - 2/2';
  static const nom = 'Nom';
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
  static const pageConnexionTitre = 'Accédez à mon compte J’agis';
  static const partagerLArticle = 'Partager l’article';
  static const passerLaQuestion = 'Passer la question';
  static const pionnier = 'Pionnier';
  static const pionnierDescription = 'Présent depuis les premiers jours';
  static const plusDe150m2 = 'Plus de 150 m²';
  static const plusieursReponsesPossibles = 'Plusieurs réponses possibles';
  static const point = '.';
  static const politiqueDeConfidentialite = 'Politique de confidentialité';
  static const politiqueDeConfidentialiteSite = 'https://jagis.beta.gouv.fr/politique-de-confidentialite';
  static const poserVotreQuestion = 'Poser votre question';
  static const notreEquipeVousRepond = ', notre équipe vous répond !';
  static const poserVotreQuestionDescription =
      'Une question ou une difficulté pour réaliser cette action ?\nNotre équipe vous répondra par email !';
  static const pourquoiCesQuestions = 'Pourquoi ces questions ?';
  static const pourquoiCesQuestionsReponse =
      'Votre revenu fiscal de référence et le nombre de parts permettent d’afficher les aides en fonction de vos ressources.';
  static const preOnboardingTitre = 'Ensemble, améliorons nos habitudes au jour le jour';
  static const premiereFoisSur = 'Première fois sur J’agis ?';
  static const prenom = 'Prénom';
  static const prixDuVelo = 'Prix du vélo';
  static const prixDuVeloExplications = 'À titre indicatif, voici quelques prix moyens';
  static const prixDuVeloObligatoire = 'Le prix du vélo ne peux pas être vide';
  static const proposePar = 'Proposé par';
  static const proposezMoiAutreChose = 'Proposez-moi autre chose';
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
  static const rechercherParTitre = 'Rechercher par titre';
  static const recolter = 'Récolter';
  static const recommencerLeBilan = 'Recommmencer le bilan';
  static const recommencerLeQuiz = 'Recommencer le quiz';
  static const refaire = 'Refaire';
  static const renvoyerCode = 'Renvoyer le code';
  static const renvoyerEmailDeConnexion = 'Renvoyer l’e-mail de connexion';
  static const reponse = 'Réponse';
  static const retentezVotreChancePourValiderCetteAction = 'Retentez votre chance pour valider cette action.';
  static const retirerDesFavoris = 'Retirer des favoris';
  static const retour = 'Retour';
  static const revenirALaThematique = 'Revenir à la thématique';
  static const revenirAuCatalogue = 'Revenir au catalogue';
  static const revenirAuSimulateur = 'Revenir au simulateur';
  static const revenuFiscal = 'Revenu fiscal de référence de mon foyer';
  static const revenuQuestion = 'Quelle est votre tranche de revenus ?';
  static const seDeconnecter = 'Se déconnecter';
  static const simulateur = 'Simulateur';
  static const simulerMonAide = 'Simuler mon aide';
  static const sources = 'Sources :';
  static const statistiques = 'Statistiques';
  static const statistiquesSite = 'https://jagis.beta.gouv.fr/statistiques';
  static const supprimerVotreCompte = 'Supprimer mon compte';
  static const supprimerVotreCompteConfirmation = 'Veuillez confirmer la suppression du compte';
  static const supprimerVotreCompteContenu =
      'Vous pouvez à tout moment choisir de supprimer votre compte ainsi que l’ensemble des données qui y sont associées.';
  static const tout = 'Tout';
  static const toutEstPret = 'Tout est prêt !';
  static const unAppartement = 'Un appartement';
  static const uneMaison = 'Une maison';
  static const valider = 'Valider';
  static const voirLaReponse = 'Voir la réponse';
  static const voirLeResultat = 'Voir le résultat';
  static const voirLesDemarches = 'Voir les démarches';
  static const voirMesResultats = 'Voir mes résultats';
  static const voirPlusActions = 'Voir plus d’actions';
  static const voirTout = 'Voir tout';
  static const voirToutesLesRecettes = 'Voir toutes les recettes';
  static const votreVehiculeActuel = 'Votre véhicule actuel';
  static const vousAvezDejaFaitCeSimulateur = 'Vous avez déjà fait ce simulateur';
  static const vousAvezDejaLOptionLaPlusEcologique = 'Vous avez déjà l’option la plus écologique !';
  static const vousAvezDejaLOptionLaPlusEconomique = 'Vous avez déjà l’option la plus économique !';
  static const vousAvezDejaUnCompte = 'Vous avez déjà un compte ?';
  static const vousAvezObtenuUnScoreKoDe = '😬 Vous avez obtenu un score de';
  static const vousAvezObtenuUnScoreOkDe = '👏 Vous avez obtenu un score de';
  static const vousAvezTermineLeQuiz = 'Vous avez terminé le quiz';
  static const vousEtesProprietaireDeVotreLogement = 'Vous êtes propriétaire de votre logement ?';
  static String a(final String value) => 'à $value';
  static String actionPerformanceTerminePart2(final String value) => '$value tonnes';
  static String actionPerformanceTerminePart3(final String value) => ' de CO₂e par an pour votre $value';
  static String actionPerformanceTermineTitle(final String value) => 'Votre bilan $value';
  static String actionsTerminees(final int nbActions) => nbActions > 1 ? 'Actions terminées' : 'Action terminée';
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

  static String donneesUtiliseesRevenuFiscal(final int? value) => '(${value == null ? '' : euro(value)})';

  static String entrezLeCodeRecuOublieMotDePasseParMailDetails(final String value) =>
      'Pour vérifier votre identité et vous permettre de modifier votre mot de passe, nous vous avons envoyé un e-mail à l’adresse : ${cacherEmail(value)}';

  static String entrezLeCodeRecuParMailDetails(final String value) =>
      'Pour vérifier votre identité et vous permettre d’accéder à votre compte, nous vous avons envoyé un e-mail à l’adresse : ${cacherEmail(value)}';

  static String euro(final int value) => '$value €';

  static String nombreAction(final int value) => value <= 1 ? '$value action' : '$value actions';

  static String nombreArticle(final int value) => value <= 1 ? '$value article' : '$value articles';

  static String nombreBadges(final int value) => value <= 1 ? '$value badge' : '$value badges';

  static String nombrePoints(final int value) => value <= 1 ? '$value point' : '$value points';
  static String pseudonymExclamation(final String value) => '$value !';

  static String questionCourantSurMax(final int actuel, final int max) => '**Question $actuel** sur $max';

  static String tempsDePreparation(final int value) => 'Temps de préparation : $value min';

  static String veloLabel(final String text) => '$text : ';

  static String votreReponse(final bool isCorrect) => '${isCorrect ? '✅' : '❌'} Votre réponse : ';
}
