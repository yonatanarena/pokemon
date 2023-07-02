import 'dart:convert';
import 'package:pokemon/resources/pokemon_api.dart';
import 'dart:developer';
import '../../models/pokemon.dart';
import '../exceptions.dart';

class PokemonService {
  static final PokemonService _singleton = PokemonService._internal();

  factory PokemonService() {
    return _singleton;
  }

  PokemonService._internal();

  Future<Pokemon> getPokemonByName(String name) async {
    var response = await PokemonApi().get("pokemon/$name");

    if (response is AppException) {
      throw response;
    }

    try {
      Map<String, dynamic> jsonResponse = json.decode(response);
      log(jsonResponse.toString());
      log(jsonResponse["moves"].toString());
      return Pokemon.fromJson(jsonResponse);
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
