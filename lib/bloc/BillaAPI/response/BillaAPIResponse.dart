class BillaAPISearchResult {
  List<String> images;
  String name;
  String url;
  late String articleId;
  BillaAPISearchResult(
      {required this.images, required this.name, required this.url}) {
    articleId = url.split("/").last;
  }

  factory BillaAPISearchResult.fromJson(Map<String, dynamic> json) {
    return BillaAPISearchResult(
        images: (json["images"] as List).map((e) => (e.toString())).toList(),
        name: json["name"],
        url: json["url"]);
  }

  Map<String, dynamic> toJson() => {
        "images": images.map((e) => e).toList().join(","),
        "name": name,
        "url": url
      };

  @override
  String toString() {
    return name;
  }
}

class BillaAPISearchResponse {
  int total;
  List<BillaAPISearchResult> results;
  BillaAPISearchResponse({required this.total, required this.results});

  factory BillaAPISearchResponse.fromJson(Map<String, dynamic> json) {
    return BillaAPISearchResponse(
        total: json["total"],
        results: (json["results"] as List)
            .map((e) => BillaAPISearchResult.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        "total": total,
        "result": results.map((e) => e.toJson()).toList().join(",")
      };
}
