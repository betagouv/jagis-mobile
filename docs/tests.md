# Les tests

Pour les tests on utilse [bdd_widget_test](https://pub.dev/packages/bdd_widget_test). C'est un package qui permet de faire des tests de type BDD ([Behavior Driven Development](https://fr.wikipedia.org/wiki/Programmation_pilot%C3%A9e_par_le_comportement)/[Gherkin](https://cucumber.io/docs/gherkin/reference)).

## Structure des fichiers

    ```sh
    test
    └── features
        ├── my_feature.feature
        ├── my_feature_test.dart
        └── step
            └── i_tap_on.dart
    ```

## Création d'un fichier .feature

Créez un fichier `my_feature.feature` dans le dossier `test/features`.

⚠️ Ne pas oublié `initializeContext()` ça permet de réinitialiser les mocks/fakes. Il est appelé avant chaque test.

```gherkin
Feature: France Connect
    Scenario: Login with FranceConnect is successful
        Given The application is launched
        When I tap on {"J’ai déjà un compte"}
        When I tap on {"FranceConnect"}
        When I'm redirect to FranceConnect callback
        Then I see {'Bienvenue sur J’agis ! Faisons connaissance...'}
```

## Génération des tests

Exécutez la commande suivante pour générer les tests flutter:

```sh
# une fois
dart run build_runner build --delete-conflicting-outputs

# ou lorsqu'un fichier est modifié
dart run build_runner watch --delete-conflicting-outputs
```

### Nouvelle step

Si la step n'existe pas, elle est crée vide. Il faut donc la coder.

## Lancer les tests

```sh
flutter test --test-randomize-ordering-seed random
```