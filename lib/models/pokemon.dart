
class Pokemon  {
  final String? name;
  final String? imageUrl;
  final List<String>? moves;

  Pokemon({this.name, this.imageUrl, this.moves});

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      name: json["name"],
      imageUrl: json["sprites"]["front_default"],
      moves: json["moves"] != null
          ? List.of(json["moves"]).map((e) => e["move"]["name"].toString()).toList()
          : List.empty());
}
