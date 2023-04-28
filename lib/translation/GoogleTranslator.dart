import 'package:google_cloud_translation/google_cloud_translation.dart';
import 'package:recipe_genius/key/googleTranslateKey.dart';

Future<String> translateFromEnToDe(String english) async {
  final Translation translation = Translation(apiKey: getGoogleTranlateKey());
  final result = await translation.translate(text: english, to: "de");

  return result.translatedText;
}
