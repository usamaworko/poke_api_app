
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';

class ApiService {
  final String baseUrl = 'https://pokeapi.co/api/v2/';

  Future<PokemonList> fetchPokemonList() async {
    final response = await http.get(Uri.parse('${baseUrl}pokemon?limit=20'));

    if (response.statusCode == 200) {
      return PokemonList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  Future<PokemonDetail> fetchPokemonDetail(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PokemonDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Pokémon details');
    }
  }
}
