import 'dart:convert';

const _appKey =
    "dict.1.1.20230412T174934Z.e76367dbbe255f71.b20c410210d6ba167615116e3e96e142c26bf24c";

class Yanday {
  late String appKey;

  Yanday() {
    appKey = _appKey;
  }

  Map<String, dynamic> toJson() => {
        'appKey': appKey,
      };

  Uri uriEnglischtoGerman(String word) {
    var temp =
        "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=$appKey&lang=en-de&text=$word";
    return Uri.parse(temp);
  }
}

class YandexResponse {
  List<String> translations;

  YandexResponse({required this.translations});

  factory YandexResponse.fromJson(Map<String, dynamic> json) {
    List<String> translations = [];
    if (json.containsKey('def')) {
      List<dynamic> def = json['def'];
      for (var item in def) {
        if (item.containsKey('tr')) {
          List<dynamic> tr = item['tr'];
          for (var translation in tr) {
            if (translation.containsKey('text')) {
              translations.add(translation['text']);
            }
          }
        }
      }
    }

    return YandexResponse(
      translations: translations,
    );
  }

  factory YandexResponse.fromRawJson(String rawJson) {
    Map<String, dynamic> json = jsonDecode(rawJson);
    return YandexResponse.fromJson(json);
  }
}
