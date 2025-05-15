abstract final class Endpoints {
  const Endpoints._();

  static const actions = '/utilisateurs/{userId}/actions';
  static const aids = '/utilisateurs/{userId}/aides_v2';
  static const bibliotheque = '/utilisateurs/{userId}/bibliotheque_v2';
  static const bilan = '/utilisateurs/{userId}/bilans/last_v3';
  // Car Simulator Endpoints
  // FIXME(erolley): Should we have sub classes for each endpoint type (eg: Endpoints.CarSimulator.getCurrentCarResult)?
  static const carSimulatorComputeCurrentCar = '/utilisateurs/{userId}/simulateur_voiture/resultat/voiture_actuelle';
  static const carSimulatorComputeOptions = '/utilisateurs/{userId}/simulateur_voiture/resultat/alternatives';

  static const creationCompte = '/utilisateurs_v2';
  static const events = '/utilisateurs/{userId}/events';
  static const franceConnectStep2 = '/login_france_connect_step_2';
  static const gamification = '/utilisateurs/{userId}/gamification';
  static const gamificationReset = '/utilisateurs/{userId}/gamification/popup_reset_vue';
  static const homeBoard = '/utilisateurs/{userId}/home_board';
  static const logement = '/utilisateurs/{userId}/logement';
  static const login = '/utilisateurs/login_v2';
  static const loginCode = '/utilisateurs/login_v2_code';
  static const logout = '/utilisateurs/{userId}/logout';
  static const lvaoSearch = '/utilisateurs/{userId}/recherche_services/longue_vie_objets/search2';
  static const modifierMotDePasse = '/utilisateurs/modifier_mot_de_passe';
  static const nationalRanking = '/utilisateurs/{userId}/classement/national';
  static const notificationToken = '/utilisateurs/{userId}/mobile_token';
  static const oubliMotDePasse = '/utilisateurs/oubli_mot_de_passe';
  static const profile = '/utilisateurs/{userId}/profile';
  static const questionsKyc = '/utilisateurs/{userId}/questionsKYC_v2';
  static const recipesCategories = '/utilisateurs/{userId}/recherche_services/recettes/categories';
  static const recipesSearch = '/utilisateurs/{userId}/recherche_services/recettes/search2';
  static const recommandationsV3 = '/utilisateurs/{userId}/recommandations_v3';
  static const renvoyerCode = '/utilisateurs/renvoyer_code';
  static const riskCity = '/utilisateurs/{userId}/risques_commune';
  static const riskStreet = '/utilisateurs/{userId}/risques_adresse';
  static const seasonalFruitsAndVegetablesCategories = '/utilisateurs/{userId}/recherche_services/fruits_legumes/categories';
  static const seasonalFruitsAndVegetablesSearch = '/utilisateurs/{userId}/recherche_services/fruits_legumes/search2';
  static const simulerAideVelo = '/utilisateurs/{userId}/simulerAideVelo';
  static const utilisateur = '/utilisateurs/{userId}';
  static const validerCode = '/utilisateurs/valider';

  static String _service(final String service) => '/utilisateurs/{userId}/recherche_services/$service';
  static String serviceCategories(final String service) => '${_service(service)}/categories';
  static String serviceSearch(final String service) => '${_service(service)}/search2';
  static String serviceDetail(final String service, final String id) => '${_service(service)}/last_results/$id';
  static String action({required final String type, required final String code}) => '/utilisateurs/{userId}/actions/$type/$code';
  static String actionFaite({required final String type, required final String code}) =>
      '${action(type: type, code: code)}/faite';
  static String actionFeedback({required final String type, required final String code}) =>
      '${action(type: type, code: code)}/feedback';
  static String actionAskQuestion({required final String type, required final String code}) =>
      '${action(type: type, code: code)}/question';
  static String aid(final String code) => '/utilisateurs/{userId}/aides/$code';
  static String article(final String contentId) => '/utilisateurs/{userId}/bibliotheque/articles/$contentId';
  static String bilanByTheme(final String type) => '/utilisateurs/{userId}/bilans/last_v3/$type';
  static String communes(final String codePostal) => '/communes?code_postal=$codePostal';
  static String confirmCustomization(final String themeCode) => '${theme(themeCode)}/personnalisation_ok';
  static String question(final String questionId) => '/utilisateurs/{userId}/questionsKYC_v2/$questionId';
  static String questions(final String sequenceId) => '/utilisateurs/{userId}/enchainementQuestionsKYC_v2/$sequenceId';
  static String questionsFirst(final String sequenceId) => '${questions(sequenceId)}/first';
  static String questionsPrevious(final String sequenceId, final String questionCode) =>
      '${questions(sequenceId)}/preceding/$questionCode';
  static String questionsNext(final String sequenceId, final String questionCode) =>
      '${questions(sequenceId)}/following/$questionCode';
  static String quiz(final String contentId) => '/utilisateurs/{userId}/bibliotheque/quizz/$contentId';
  static String quizScore(final String contentId) => '/utilisateurs/{userId}/actions/quizz/$contentId/score';
  static String recipe(final String recipeId) => '/utilisateurs/{userId}/recherche_services/recettes/last_results/$recipeId';
  static String replaceAction({required final String themeCode, required final String type, required final String code}) =>
      '/${theme(themeCode)}/actions/$type/$code';
  static String resetCustomization(final String themeCode) => '${theme(themeCode)}/reset_personnalisation';

  static String servicesParThematique(final String themeCode) => '${theme(themeCode)}/recherche_services';
  static String theme(final String themeCode) => '/utilisateurs/{userId}/thematiques/$themeCode';
}
