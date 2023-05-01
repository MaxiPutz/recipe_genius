# recipe_genius

Recipe Genius is an app that helps you find recipes based on the ingredients you have on hand. It integrates with the Edamam and Billa APIs to provide a rich database of recipes and products. The app also uses the Google Translate API to translate recipe instructions and ingredient names between languages.

# Installation
To install the app, follow these steps:

1. Clone the repository to your local machine.

2. Create a key folder in the lib directory.

3. Inside the key folder, create two files: edmamKey.dart and googleTranslateKey.dart.

4. In the edmamKey.dart file, define your Edamam API ID and key as follows:

```dart

class APIKey {
  late String appID;
  late String appKey;

  APIKey() {
    appID = "<your edmam id>";
    appKey = "<your edmam key>";
  }

  Map<String, dynamic> toJson() => {
        'appID': appID,
        'appKey': appKey,
      };
}
```
In the googleTranslateKey.dart file, define your Google Translate API key as follows:

```dart
Copy code
String getGoogleTranlateKey() {
  return "<your google translate key>";
}
```
Save the files and run the app.

# API Integration
This app uses three APIs to provide its core functionality:

## Edamam API
The Edamam API is used to find recipes based on the ingredients provided by the user. This API provides a rich database of recipes, but it is primarily in English. To ensure that Recipe Genius can provide recipes in multiple languages, I have integrated the Google Translate API to translate the recipe instructions.

## Google Translate API
The Google Translate API is used to translate the recipe instructions and ingredient names retrieved from the Edamam API to the language selected by the user. This integration ensures that the recipe instructions and ingredient names are available in a language that the user can understand.

## Billa API
The Billa API is used to find the products that are required to prepare the recipe. This API is primarily in German, so I first translate the ingredient names using the Google Translate API and then use the translated names to search for the products in the Billa API.

To use these APIs, you will need to obtain API keys from the respective providers and store them in the edmamKey.dart and googleTranslateKey.dart files as shown in the installation instructions. Please note that you will need to have an active subscription to the Edamam and Billa APIs to use them in production.

## Usage
To use Recipe Genius, simply enter the ingredients you have on hand and select your preferred language. Recipe Genius will then search the Edamam database for recipes that use those ingredients and provide you with a list of results. You can select a recipe to see its instructions, which will be translated into the language you selected.

If you decide to prepare the recipe, Recipe Genius will use the translated ingredient names to search for the required products in the Billa API. You can then order the products directly from Billa to complete the recipe.

## License
Recipe Genius is licensed under the MIT License. See LICENSE for more information.

##Acknowledgments
Recipe Genius was created by maxiputz. Special thanks to the creators of the Edamam, Google Translate, and Billa APIs for providing the data used by the app.
