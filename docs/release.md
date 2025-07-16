# Release

## Setup

- [Android](android/build.md)
- [iOS](ios/build.md)

## Publier une nouvelle version sur les stores iOS et Android

### 1. Préparer la version

1. Créer une branche `chore/release-X.X.X` (remplacer X.X.X par le numéro de version)
2. Mettre à jour la version dans le fichier [app/pubspec.yaml](../app/pubspec.yaml)

   Laisser le +0, il sera modifié automatiquement avec le numéro de l'action GitHub.

   ```yaml
   name: app
   description: "J’agis vous accompagne à chaque étape de la transition écologique."
   publish_to: "none"
   version: X.X.X+0 <----- Modifier ici

   environment:
     sdk: 3.8.1
     flutter: 3.32.6
   ```

3. Committer avec le message `chore: release X.X.X`
4. Fusionner sur main

### 2. Lancer le processus de build

1. Aller sur la [page Continuous Delivery](https://github.com/betagouv/jagis-mobile/actions/workflows/continuous-delivery.yml)
2. Cliquer sur `Run workflow` puis sur `Run workflow`

   ![Appuyer sur Run workflow et encore sur Run workflow](release/run_workflow.png)

   L'action va créer les versions iOS et Android pour l'environnement Dev, puis attendre une validation manuelle pour la version Prod.

3. Valider la version de dev : cliquer sur `Review deployments`, cocher `production` puis `Approve and deploy`

### 3. Publier sur Google Play Store (Android)

1. Télécharger l'artéfact généré par l'action GitHub
2. Aller sur [Google Play Console](https://play.google.com/console/u/1/developers/9006095743383319605/app-list)
3. Sélectionner l'application `J’agis - Dev` ou `J’agis`
4. Naviguer vers `Tester et publier > Tests > Tests internes`
  
   ![Tester et publier > Tests > Tests internes](release/side_bar_tests_internes.png)

5. Cliquer sur `Créer une version`
6. Extraire l'artéfact téléchargé, cliquer sur `Importer` et choisir le fichier `app-development-release.aab` ou `app-production-release.aab`
7. Cliquer sur `Suivant` puis sur `Enregistrer et publier`
8. Sur la page Tests internes, cliquer sur `Promouvoir la release` puis `Production`
9. Cliquer sur `Suivant`, `Enregistrer`, `Accéder à l'aperçu`
10. Confirmer avec `Envoyer 1 modification pour examen ?` puis `Envoi des modifications pour examen`

### 4. Publier sur App Store (iOS)

1. Télécharger l'artéfact iOS généré par l'action GitHub
2. Aller sur [App Store Connect](https://appstoreconnect.apple.com/)
3. Sélectionner l'application J’agis
4. Aller dans l'onglet `Apps` puis sélectionner l'app J’agis
5. Cliquer sur `Ajouter une plateforme`
6. Saisir le numéro de version (X.X.X)
7. Dans la section `Build`, cliquer sur `Choisir` et sélectionner le build correspondant
8. Remplir les informations de mise à jour (nouveautés, corrections, etc.)
9. Cliquer sur `Enregistrer` puis `Envoyer pour examen`
10. Une fois approuvé par Apple, cliquer sur `Publier cette version`

### Notes importantes

- Les versions de développement doivent être testées avant la publication en production
- Les délais d'approbation peuvent varier : quelques heures pour Google Play, 24-48h pour l'App Store
- Vérifier que toutes les métadonnées (description, captures d'écran, etc.) sont à jour avant la publication
