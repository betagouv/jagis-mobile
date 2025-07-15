# Release

## Setup

- [Android](android/build.md)
- [iOS](ios/build.md)

## Faire une nouvelle version

1. Créer une branche `chore/release-1.6.3`
1. Changer la version dans le fichier [app/pubspec.yaml](../app/pubspec.yaml)

  Laisser le +0 il est modifié avec le numéro de l'action github.

  ```yaml
  name: app
  description: "J’agis vous accompagne à chaque étape de la transition écologique."
  publish_to: "none"
  version: 1.6.3+0 <----- ICI

  environment:
    sdk: 3.8.1
    flutter: 3.32.6
  ```

1. Mettre en message de commit `chore: release 1.6.3`
1. Fusionner sur main
1. Aller sur la [page Continuous Delivery](https://github.com/betagouv/jagis-mobile/actions/workflows/continuous-delivery.yml)
1. Appuyer sur `Run workflow` et encore sur `Run workflow`

  ![Appuyer sur Run workflow et encore sur Run workflow](release/run_workflow.png)

  L'action va crée les versions iOS et Android en premier pour la version Dev et après validation manuel la version Prod.

1. Valider la version de dev, appuyer sur `Review deployments`, cocher `production` puis appuyer sur `Approve and deploy`

## Android

1. Sur Android, il faut téléchargé l'artéfact et aller sur [Google Play Console](https://play.google.com/console/u/1/developers/9006095743383319605/app-list)
1. Sélectionner l'application `J’agis - Dev` ou `J’agis`
1. `Tester et publier > Tests > Tests internes`
  
  ![Tester et publier > Tests > Tests internes](release/side_bar_tests_internes.png)

1. Cliquer sur `Créer une version`
1. Il faut unzip l'artéfact télécharger précédemment, cliquer sur `Importer` et choisir le fichier `app-development-release.aab` ou `app-production-release.aab`
1. Cliquer sur `Suivant` puis sur `Enregistrer et publier`
