# Gecipe Genius

Recipe Genius is an app that helps you find recipes based on the ingredients you have on hand. It integrates with the Edamam and Billa APIs to provide a rich database of recipes and products. The app also uses the Google Translate API to translate recipe instructions and ingredient names between languages.
![output](https://user-images.githubusercontent.com/48091139/235503165-9b36efe0-b054-4987-b866-375b9b8804b4.gif)


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
5. In the googleTranslateKey.dart file, define your Google Translate API key as follows:

```dart

String getGoogleTranlateKey() {
  return "<your google translate key>";
}
```
6. Save the files and run the app.

# Technologies Used

This app was built using the following technologies:

- Flutter (https://flutter.dev/)
- Dart (https://dart.dev/)
- APIs:
  - Edamam API (https://developer.edamam.com/edamam-docs-recipe-api)
  - Google Translate API (https://cloud.google.com/translate)
  - Billa API (https://siteapi.vorbestellservice.billa.at/index.html)
- Bloc (https://bloclibrary.dev/)
- Material UI (https://flutter.dev/docs/development/ui/widgets/material)

These technologies were chosen for their reliability, ease of use, and integration with the Flutter framework. By using these technologies, we were able to build a powerful and user-friendly app that helps users find and prepare delicious recipes with ease.


# API Integration
This app uses three APIs to provide its core functionality:

## Edamam API
The Edamam API is used to find recipes based on the ingredients provided by the user. This API provides a rich database of recipes, but it is primarily in English. To ensure that Recipe Genius can provide recipes in multiple languages, I have integrated the Google Translate API to translate the recipe instructions.
https://developer.edamam.com/edamam-recipe-api

## Google Translate API
The Google Translate API is used to translate the recipe instructions and ingredient names retrieved from the Edamam API to the language selected by the user. This integration ensures that the recipe instructions and ingredient names are available in a language that the user can understand.
https://cloud.google.com/translate/docs/reference/rest

## Billa API
The Billa API is used to find the products that are required to prepare the recipe. This API is primarily in German, so I first translate the ingredient names using the Google Translate API and then use the translated names to search for the products in the Billa API.
https://adminapi.vorbestellservice.billa.at/index.html

## Usage
1. Search for a recipe by entering keywords in the search bar and clicking the "Search" button.
2. Browse the list of search results and select the recipe you want to view.
3. On the recipe details page, scroll down to the "Ingredients" section to see the ingredients required for the recipe.
4. Use the "Servings" field to adjust the serving size of the recipe as needed.
5. Click the "Add to shopping list" button to add the recipe to your shopping list.
6. Repeat steps 1-5 for all the recipes you want to cook.
7. Go to the shopping list view to view all the ingredients you need to purchase.
8. Find the best products to buy for the ingredients on your shopping list
9. Go to the ceckout fill in the AnonymousCartId and press the send button.

https://user-images.githubusercontent.com/48091139/235498503-7e5fd7c4-9ef9-4394-a83f-a8125115dafa.mp4

If you decide to prepare the recipe, Recipe Genius will use the translated ingredient names to search for the required products in the Billa API. You can then order the products directly from Billa to complete the recipe.

## License
Recipe Genius is licensed under the MIT License. See LICENSE for more information.

## Acknowledgments
Recipe Genius was created by maxiputz. Special thanks to the creators of the Edamam, Google Translate, and Billa APIs for providing the data used by the app.
